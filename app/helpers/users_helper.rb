module UsersHelper
	def gravatar_for(email, size)
        gravatar_id = Digest::MD5::hexdigest(email)
        gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    end
end
