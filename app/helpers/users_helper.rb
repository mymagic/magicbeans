module UsersHelper
	def gravatar_for(email, size)
        gravatar_id = Digest::MD5::hexdigest(email)
        gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    end

    def profile_picture(user)
        if user.image.blank?
            gravatar_for(user.email, 150)
        else
            user.image.url
        end
    end

    def is_admin?
        if user_signed_in? && current_user.has_role?('admin')
        	true
        else
        	false
        end
    end
end
