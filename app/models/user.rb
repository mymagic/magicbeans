class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_and_belongs_to_many :roles

  def is_admin?
    
    roles.include?(Role.find_by_name('Admin'))
    
  end

end
