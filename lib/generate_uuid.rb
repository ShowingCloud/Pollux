require 'securerandom'

module GenerateUuid

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

end
