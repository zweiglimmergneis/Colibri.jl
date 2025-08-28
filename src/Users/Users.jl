module Users

using HTTP
using Oxygen
using Hyperscript
using ...Sessions
import ...View: render




# Controller

"""
    function login()
"""
function login(req::HTTP.Request)
    if req.method == "GET"
        login_form()
    else
        try
            user_id = parse(Int32, formdata(req)["user_id"])
            session = Sessions.get(user_id)
            cookie = HTTP.Cookies.Cookie("id", session.id)
            response = login_msg("Login erfolgreich")
            HTTP.Cookies.addcookie!(response, cookie)
            return response
        catch e
            msg = "";
            if :msg in propertynames(e)
                msg = e.msg
            end
            return login_msg("Login nicht moglich: " * string(typeof(e)) * msg)
        end
    end
end

# Model

# View

"""
   login_form()
"""
function login_form()
    form = m("form", method="post",
             m("label", "User ID"; :for => "user_id"),
             m("input"; :type => "text", id="user_id", name="user_id", class="form-control"))
    content_node = m("div", m("div", form; class="col-4"); class="row mt-2")
    return render("Colibri Login", content_node)
end

function login_msg(msg)
    content_node = m("div", m("div", msg; class="col-12"); class="row mt-2")
    return render("Colibri Login", content_node)
end

end # module
