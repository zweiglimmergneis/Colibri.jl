module Story

using HTTP
using Markdown
using ...App
import ...View: render


function story(req::HTTP.Request, title, path)
    file_path = joinpath(App.APP_PATH, path)
    render(title, Markdown.parse(readchomp(file_path)))
end
    


end # module Story

