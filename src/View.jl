module View

using Hyperscript
using Oxygen
using Colibri.Model

"""
    head(title)

return head-Element of an HTML document

include bootstrap via cdn
"""        
function head(title)
    m("head",
      m("meta", charset="utf-8"),
      m("meta", name="viewport", content="width=device-width, initial-scale=1.0"),
      m("title", title),
      m("link", rel="icon", type="image/png", sizes="32x32", href="/static/favicon-32x32.png"),
      m("link", 
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css",
        rel="stylesheet",
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH",
          crossorigin="anonymous"),
      m("link",
        rel="stylesheet",
        href="/static/css/app.css"),
      m("script",         
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js",
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz",
        crossorigin="anonymous",
        defer=nothing),
      )
end

"""
    render(title, body)

return an HTML-Response including `title` and `body`
"""
function render(title, content)
    banner_node = m("div",
                    m("img";
                      src="/static/img/colibri_banner.jpg",
                      alt="Moorwiese by Isny",
                      class="text-center banner"))
    document=string(
        "<!DOCTYPE html>\n",
        Pretty(
            m("html",
              head(title),
              m("body",
                m("div",
                  banner_node,
                  content;                  
                  class="container-fluid mt-2")
                );
              lang="de")))
    return html(document)
end


"""
    home(welcome)

show welcome message
"""
function home(welcome)
    title = "Colibri"
    content = m("div", class="row m-2",
        m("div", class="col",
            m("h1", welcome)
        )
    )
    return render(title, content)
end

function render_accordion()    
    div_node = m("div")
    h2_node = m("h2")
    button_node = m("button")
    strong_node = m("strong")
    code_node = m("strong")
    
    accordion_item_1 = div_node(class="accordion-item")(
        h2_node(class="accordion-header")(
            button_node(class="accordion-button", 
                type="button", 
                dataBsToggle="collapse", 
                dataBsTarget="#collapseOne", 
                ariaExpanded="true", 
                ariaControls="collapseOne")("Accordion Item #1")
        ),
        div_node(id="collapseOne", class="accordion-collapse collapse show", dataBsParent="#accordionExample")(
            div_node(class="accordion-body")(
                strong_node("This is the first item's accordion body."),
                " It is shown by default, until the collapse plugin adds the appropriate classes that we use to style each element. ",
                "These classes control the overall appearance, as well as the showing and hiding via CSS transitions. ",
                "You can modify any of this with custom CSS or overriding our default variables. ",
                "It's also worth noting that just about any HTML can go within the ", code_node(".accordion-body"), ", though the transition does limit overflow."
            )
        )
    )
    return accordion_item_1
    """
    <div class="accordion-item">
        <h2 class="accordion-header">
        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
            Accordion Item #1
        </button>
        </h2>
        <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
        <div class="accordion-body">
            <strong>This is the first item's accordion body.</strong> It is shown by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
        </div>
        </div>
    </div>
    <div class="accordion-item">
        <h2 class="accordion-header">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
            Accordion Item #2
        </button>
        </h2>
        <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
        <div class="accordion-body">
            <strong>This is the second item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
        </div>
        </div>
    </div>
    <div class="accordion-item">
        <h2 class="accordion-header">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
            Accordion Item #3
        </button>
        </h2>
        <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
        <div class="accordion-body">
            <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
        </div>
        </div>
    </div>
    </div>
    """
    return render_all("Colibri", accordion)
end

"""
    render(form::Model.EditForm)

"""
function make_node(form::Model.EditForm{T} where T<:Model.AbstractEntity)
    m("form", method="post",
        m("label", "Familienname"; :for => "family_name"),            
        m("input"; :type => "text", id="family_name", name="family_name"),
    )
end

# 2025-02-02 work with types

abstract type Layout end;

struct Base<:Layout
    title::String    
    body
    flags::Vector{Symbol}
end

function Base(title, body; flags=[])
    return Base(title, body, flags)
end

function render(layout::Base)
    node = m("head",
        m("meta", charset="utf-8"),
        m("meta", name="viewport", content="width=device-width, initial-scale=1.0"),
        m("title", layout.title),
        m("link", rel="icon", type="image/png", sizes="32x32", href="/assets/favicon-32x32.png"))
    if :bootstrap in layout.flags
        node = node(
            m("link", 
                href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css",
                rel="stylesheet",
                integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH",
                crossorigin="anonymous"),
            m("script",         
                src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js",
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz",
                crossorigin="anonymous",
                defer=nothing))
    end
    node = node(body)
end

# TODO handle POST
function login(action = "receive_login") 
    m("form", 
        m("label", "Username"; class="form-label", :for => "username"),        
        m("input"; :type => "text", id="username", name="username", class="form-control", ariaLabel="Username"),
        m("button", "ok"; :type => "button", class="btn btn-secondary");
        method="post",
        action=action
    )    
end

end
