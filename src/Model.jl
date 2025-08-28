module Model

export AbstractEntity, EditForm

"""
    AbstractEntity

Data Container
"""
abstract type AbstractEntity end

"""
    Person
"""
struct Person<:AbstractEntity
    id::Int
    family_name::String
    given_name::String
    age::Int
end

# move this to other module
"""
    EditForm
"""
struct EditForm{T<:AbstractEntity}
    label::String
    id::String        # default typeof(entity) * "-" * entity.id
    entity::T
    field_label_list::Dict{Symbol, String}
    field_type_list::Dict{Symbol, String}
end

EditForm(entity) = EditForm("form", "form_1", entity, Dict{Symbol, String}(), Dict{Symbol, String}())

end # module Model