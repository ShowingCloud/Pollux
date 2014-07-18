class User < ActiveRecord::Base
  include PasswordCrypt, GenerateUuid

  before_create :generate_uuid
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses

end
