class User < ActiveRecord::Base
  before_create :generate_uuid
  has_many :addresses

  private
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
