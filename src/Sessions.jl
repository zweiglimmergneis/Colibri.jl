module Sessions
using UUIDs
using Dates

mutable struct Session
    id::String # UUID
    user_id::UInt32
    lastURI::String
    touch::DateTime
end

const LIFETIME = Dates.Minute(2)

const SESSIONS = Dict{fieldtype(UUID, :value), Session}()

function get(user_id = 0)
    uuid = uuid4()
    session = Session(string(uuid), user_id, "", now());
    push!(SESSIONS, uuid.value => session)
    return session
end

function valid(session::Session)
    return sesssion.touch + LIFETIME < now()
end


end # module 
