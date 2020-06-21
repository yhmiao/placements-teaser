class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable

  SEARCHABLE = ['users.email'].freeze
end
