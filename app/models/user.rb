class User < ActiveRecord::Base
  has_many :authentications
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def apply_omniauth(auth)
    authentications.build(provider: auth['provider'],
                          uid: auth['uid'],
                          token: auth['credentials']['token'],
                          secret: auth['credentials']['secret'])
  end

  def password_required?
    authentications.empty? || !password.blank? && super
  end

end
