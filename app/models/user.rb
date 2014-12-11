class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]


  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.photo = auth.info.image
        user.token = auth.credentials.token
        user.password = Devise.friendly_token[0,20]
        user.skip_confirmation!
        user.save
      end
  end

#   def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
#   data = access_token.info
#     user = User.find_by(email: data.email)
#     if user
#       # .has_role?('Admin')
#       user.provider = access_token.provider
#       user.uid = access_token.uid
#       user.token = access_token.credentials.token
#       user.save
#       user
#     else
#       redirect_to new_user_registration_path, notice: "Error."
#     end
# end


  has_and_belongs_to_many :roles

  def confirmed?
    confirmed_at.present?
  end

  def has_role?(name)
    roles.include?(Role.find_by_name(name))
  end
  
  def add_role(role)
    if  the_role = Role.find_by_name(role)
        roles.push(the_role)
    end
  end
  
  def delete_role(role)
    if  the_role = Role.find_by_name(role)
        roles.delete(the_role)
    end
  end
  
  def list_roles
    roles.map(&:name)
  end

end
