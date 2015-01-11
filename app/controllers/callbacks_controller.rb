class CallbacksController < Devise::OmniauthCallbacksController
    def facebook
        @user = User.from_omniauth(request.env["omniauth.auth"])
        sign_in_and_redirect @user
    end

    def twitter
        @user = User.from_omniauth(request.env["omniauth.auth"])
        sign_in_and_redirect @user
    end

    def google_oauth2
        @user = User.from_omniauth(request.env["omniauth.auth"])
        @auth = request.env['omniauth.auth']['credentials']
        Token.create(
            access_token: @auth['token'],
            refresh_token: @auth['refresh_token'],
            expires_at: Time.at(@auth['expires_at']).to_datetime)
        sign_in_and_redirect @user
    end

end