class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, 'testedetoken')
  end

  def self.decode(token)
    decoded = JWT.decode(token, 'testedetoken')[0]
    HashWithIndifferentAccess.new(decoded)
  rescue JWT::DecodeError
    nil
  end
end
