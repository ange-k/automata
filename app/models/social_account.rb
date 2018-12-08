class SocialAccount < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  protected
  def self.find_for_google_oauth2(auth)
    user = SocialAccount.find_by(email: auth.info.email)

    unless user
      user = SocialAccount.create(
                         email: auth.info.email,
                         name:     auth.info.name,
                         provider: auth.provider,
                         uid:      auth.uid,
                         token:    auth.credentials.token,
                         password: Devise.friendly_token[0, 20])
      Rails.logger.error user.errors.inspect if user.errors.present?
    end
    user
  end
end
