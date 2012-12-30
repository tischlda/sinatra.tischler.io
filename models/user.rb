class User
  include Mongoid::Document

  field :name, type: String
  field :givenName, type: String
  field :surName, type: String
  field :fullName, type: String
  field :phone, type: String
  field :email, type: String
  field :web, type: String
  field :skype, type: String
  field :facebook, type: String
  field :github, type: String
  field :stackoverflow, type: String
  field :xing, type: String
  field :about, type: String
end