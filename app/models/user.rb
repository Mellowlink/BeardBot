class User < ApplicationRecord
  has_many :conversations

  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

  EMAIL = /
    \A
    [A-Z0-9_.&%+\-']+   # mailbox
    @
    (?:[A-Z0-9\-]+\.)+  # subdomains
    (?:[A-Z]{2,25})     # TLD
    \z
  /ix
  LOGIN = /\A[a-zA-Z0-9_][a-zA-Z0-9\.+\-_@ ]+\z/

  validates :email,
    format: {
      with: EMAIL,
      message: proc {
        ::Authlogic::I18n.t(
          "error_messages.email_invalid",
          default: "should look like an email address."
        )
      }
    },
    length: { maximum: 100 },
    uniqueness: {
      case_sensitive: false,
      if: :will_save_change_to_email?
    }

  validates :username,
    format: {
      with: LOGIN,
      message: proc {
        ::Authlogic::I18n.t(
          "error_messages.login_invalid",
          default: "should use only letters, numbers, spaces, and .-_@+ please."
        )
      }
    },
    length: { within: 3..20 },
    uniqueness: {
      case_sensitive: false,
      if: :will_save_change_to_username?
    }

  validates :password,
    confirmation: { if: :require_password? },
    length: {
      minimum: 8,
      if: :require_password?
    }
  validates :password_confirmation,
    length: {
      minimum: 8,
      if: :require_password?
  }

  def deliver_password_reset_instructions!
    reset_perishable_token!
    PasswordResetMailer.reset_email(self).deliver_now
  end

end
