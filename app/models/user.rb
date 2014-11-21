class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
<<<<<<< Updated upstream
         :recoverable, :rememberable, :trackable, :validatable
         
=======
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
>>>>>>> Stashed changes

end
