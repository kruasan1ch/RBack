require 'webrick'
require 'erb'
require_relative 'templates'
require_relative 'argument'
require_relative 'pi_pos'

include Pos
include WEBrick
include Arguements

s = HTTPServer.new(:Port => 8020)
index   = Template.new('index.html')
result  = Template.new('result.html')
error   = Template.new('error.html')

s.mount_proc("/") do |req, res|
    $arguments = Array.new
    $arguments[Arguements::A] = Argument.new(4.4, 5.0, 0.02, 4.4, 'A')
    $arguments[Arguements::B] = Argument.new(3.0, Math::PI.round(4), 0.001, 3.0, 'B')
    $arguments[Arguements::B].pi_pos=PiPos.new(true, Pos::RIGHT)
    $arguments[Arguements::C] = Argument.new(140.0, 142.0, 0.1, 140.0, 'C')
    $arguments[Arguements::D] = Argument.new(0.02, 0.3, 0.001, 0.02, 'D')
    $arguments[Arguements::X] = Argument.new(0.01, 0.12, 0.0105, 0.01, 'X')
    index.reload_template
    res.body = index.render
end

s.mount_proc("/res") do |req, res|
    $arguments[Arguements::A].value=req.query["A"].to_f
    $arguments[Arguements::B].value=req.query["B"].to_f
    $arguments[Arguements::C].value=req.query["C"].to_f
    $arguments[Arguements::D].value=req.query["D"].to_f
    $arguments[Arguements::X].value=req.query["X"].to_f
    found_error = false
    faulted = Array.new
    for argument in $arguments do
        if not argument.validate
            faulted << argument.name
            found_error = true
        end
    end
    if not found_error
        a = req.query["A"].to_f
        b = req.query["B"].to_f
        c = req.query["C"].to_f
        d = req.query["D"].to_f
        x = req.query["X"].to_f
        f = a*((x**5)+b*(x**3)) + c*x +(d/(x**2)) 
        result.reload_template
        res.body = result.get_template.result(binding)
    else
        f = faulted.to_s
        error.reload_template
        res.body = error.get_template.result(binding)
    end
    
end

trap("INT") {s.shutdown}
s.start
