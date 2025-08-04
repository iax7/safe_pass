module JsonWebToken
  SECRET_KEY = Rails.application.credentials.secret_key_base

  def self.encode(payload, exp = 2.minutes.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY).first
    HashWithIndifferentAccess.new(body)
  rescue JWT::ExpiredSignature
    raise JsonWebTokenError, "Token has expired"
  rescue JWT::DecodeError
    raise JsonWebTokenError, "Invalid token"
  end

  class JsonWebTokenError < StandardError; end
end
