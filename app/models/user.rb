class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_create :do_mailchimp

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]


  mount_uploader :image, ImageUploader


         

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.photo = auth.info.image
        user.password = Devise.friendly_token[0,20]
        user.skip_confirmation!
        user.save
      end
  end

  with_options on: :update, presence: true do |u|
    u.validates :name
    u.validates :phone
    u.validates :ic, format: { with: /\A\d{6}-\d{2}-\d{4}\z/, message: "Invalid IC Format" }, uniqueness: true
  end

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
  
    def do_mailchimp
        gb = Gibbon::API.new("b8dde85c99971a03fa2887fb3847ade4-us9")
        gb.lists.subscribe({:id => 'e00ef5b132', 
         :email => {:email => self.email }, :merge_vars => {:WHAT_ARE_Y => "user"},
         :double_optin => false})
    end
  
 

end
