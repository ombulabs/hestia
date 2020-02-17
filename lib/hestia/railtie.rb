require "hestia"

module Hestia
  class Railtie < ::Rails::Railtie
    # Hooks into ActionDispatch::Session::SignedCookieJar to allow rotating secret tokens in signed cookies.
    #
    # See README.md for how to configure this in your application.
    #
    initializer "hestia.signed_cookie_jar_extension", before: :load_config_initializers do
      case ActionPack::VERSION::MAJOR
      when 3
        extension = Hestia::SignedCookieJarExtension::ActionPack3
        ActionDispatch::Cookies::SignedCookieJar.prepend(extension)
      when 4
        Hestia.check_secret_key_base
        extension = Hestia::SignedCookieJarExtension::ActionPack4
        ActionDispatch::Cookies::SignedCookieJar.prepend(extension)
      when 5
        if ActionPack::VERSION::MINOR == 2
          Hestia.check_secret_key_base
          extension = Hestia::SignedCookieJarExtension::ActionPack5
          ActionDispatch::Cookies::SignedKeyRotatingCookieJar.prepend(extension)
        else
          Hestia.check_secret_key_base
          extension = Hestia::SignedCookieJarExtension::ActionPack5
          ActionDispatch::Cookies::SignedCookieJar.prepend(extension)
        end
        
      end

      
    end
  end
end
