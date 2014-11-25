module UsersHelper
	def gravatar_for(email, size)
        gravatar_id = Digest::MD5::hexdigest(email)
        gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    end

    def is_admin?
    	if user_signed_in?
    		current_user.roles.include?(Role.find_by_name('Admin'))
    	end
    end
end
