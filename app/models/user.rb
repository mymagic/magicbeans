class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_and_belongs_to_many :roles
  
  def is_admin?
    roles.include?(Role.find_by_name('Admin'))
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
