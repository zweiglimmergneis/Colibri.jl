module Colibri


using Oxygen
using HTTP

include("App.jl")
include("Model.jl") # legacy 2025-02-02
include("View.jl")
include("Sessions.jl")
include("Controller.jl") # legacy 2025-02-02
include("Users/Users.jl")
include("Story/Story.jl")

using .App

function register_static()
    staticfiles(joinpath(App.APP_PATH, "assets"), "static")
end

function register_routes()
    get(Controller.welcome, "/")
    # @get "/accordion" Controller.accordion
    # @get "/query" Controller.query_conductor
    # @get "/read-cookies" Controller.read_cookies
    # @get "/edit-a-person" Controller.edit_person
    get(Users.login, "/login")
    post(Users.login, "/login")
    get("story/bees") do req::HTTP.Request
        Story.story(req, "Bienen", "story/bees.md")
    end
end

function testUserLogin() 
    req = HTTP.Request("GET", "www.dlr.de")
    User.login(req)
end

end
