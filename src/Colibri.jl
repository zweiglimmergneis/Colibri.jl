module Colibri

using Oxygen
using HTTP

function welcome()
    println("This is Colibri, a minimal web framework")
end

function webinit(req::HTTP.Request)
    msg = "This is Colibri in your Browser"
    return msg
end

@get "/start" webinit

end
