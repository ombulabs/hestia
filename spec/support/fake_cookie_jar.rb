class FakeCookieJar
  attr_reader :request, :key_generator, :signed_cookie_salt, :cookies_digest, :signed_cookie_digest

  def initialize(secret)
    @secret = secret
    @request = self
    @signed_cookie_salt = "salt"
    @cookies_digest = nil
    @signed_cookie_digest = nil
    @key_generator = ActiveSupport::LegacyKeyGenerator.new(@secret)
  end

  def secret_token
  	nil
  end

  def cookies_rotations
  	Sasa.new
  end
end

class Sasa
	def signed
		[Class.new do
          def key_generator
            ActiveSupport::KeyGenerator.new("secret")
          end
        end.new]
	end
end
