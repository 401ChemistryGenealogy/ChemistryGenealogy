class Api::InstitutionSerializer < ActiveModel::Serializer
  attributes :id, :name, :approved
end
