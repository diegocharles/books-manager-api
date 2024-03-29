# frozen_string_literal: true

class JsonWebTokenHelper
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.encode(payload, exp = 1.month.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, false)[0]
    HashWithIndifferentAccess.new decoded
  end
end
