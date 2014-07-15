class Address < ActiveRecord::Base
  before_create :generate_uuid
  belongs_to :user

  private
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
