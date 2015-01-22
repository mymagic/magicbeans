# config/initializers/koala.rb
# Simple approach
Koala::Facebook::OAuth.class_eval do
  def initialize_with_default_settings(*args)
    raise "application id and/or secret are not specified in the environment" unless Magicbean.fb_app_id && Magicbean.fb_app_secret
    initialize_without_default_settings(Magicbean.fb_app_id.to_s, Magicbean.fb_app_secret.to_s, args.first)
  end 

  alias_method_chain :initialize, :default_settings 
end