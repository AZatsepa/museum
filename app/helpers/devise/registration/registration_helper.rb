module Devise
  module Registration
    module RegistrationHelper
      def password_placeholder
        return t('registration.password') unless @minimum_password_length
        "#{t('registration.password')} (#{@minimum_password_length}  #{t('registration.password_min')})"
      end
    end
  end
end