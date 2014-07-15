class User < ActiveRecord::Base
  before_create :generate_uuid
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses

  private
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
