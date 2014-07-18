require 'password_crypt'

class ActionController::Parameters
  include PasswordCrypt
end
