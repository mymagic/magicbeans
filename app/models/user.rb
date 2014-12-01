class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  with_options on: :update, presence: true do |u|
    u.validates :name
    u.validates :phone
    u.validates :ic, format: { with: /\A\d{6}-\d{2}-\d{4}\z/, message: "Invalid IC Format"   }
  end

  has_and_belongs_to_many :roles

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
