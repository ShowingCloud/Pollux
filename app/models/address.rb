class Address < ActiveRecord::Base
  include GenerateUuid
  before_create :generate_uuid
end
