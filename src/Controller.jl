module Controller

using HTTP
using Hyperscript

using ..View
using Colibri.Model

export welcome, version, query_conductor

"""
    version()

dummy fuction for tests
"""
function version()
    version = "v0.0.1"
    return version
end

function welcome(req::HTTP.Request)
    msg = "Welcome to Colibri!"
    return View.render("Colibri", m("h1", msg))                       
end

"""
    welcome_with_cookies(req::HTTP.Request)

show welcome message
"""
function welcome_with_cookies(req::HTTP.Request)
    msg = "Welcome to Colibri!"
    resp = View.home(msg)
    cookie_list = HTTP.cookies(req)
    @info cookie_list    
    st_cookie = HTTP.Cookies.Cookie("penalty", "seventeen")
    HTTP.Cookies.addcookie!(resp, st_cookie)
    return resp
end

"""
    read_cookies(req::HTTP.Request)
"""
function read_cookies(req::HTTP.Request)
    cookie_list = HTTP.cookies(req)
    @info cookie_list
    msg = "Cookies erhalten?"    
    return View.home(msg)
end

"""
    query_conductor(req::HTTP.Request)

show query form    
"""
function query_conductor(req::HTTP.Request)
    form = ""
    return View.query()
end

"""
    edit_person(req::HTTP.Request)
"""
function edit_person(req::HTTP.Request)
    person = Model.Person(17, "Karl", "Schreiner", 35)
    form = Model.EditForm(person)    
    m_form = View.make_node(form)
    View.render_all("Wer ist das?", m_form)
end

function edit_person_save(req::HTTP.Request)
    data = formdata(req)
    return data
end

"""
    login(req::HTTP.Request)
"""
function login(req::HTTP.Request)
    View.render_all("Login", View.login())
end

function receive_login(req::HTTP.Request)
    return formdata(req)
end




end
