class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    # before_filter :ensure_signup_complete, only: [:new, :create, :update, :destroy]
    load_and_authorize_resource
<<<<<<< HEAD

=======
    
>>>>>>> Messed with skip_confirmation, Reverted back to original
    def new
        @user = User.new
        @roles = Role.all

        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @user }
        end
    end
    
    def index
        @users = User.all
    end
    
    def show
        @user = User.find(params[:id])
    end
    
    def edit
        @user = User.find(params[:id])
        @roles = Role.all
    end
    
    def create
        @user = User.new(user_params)
        roles = params[:roles]
        if !@user.roles.empty?
        @user.roles.delete_all
        end
        if !roles.blank?
            roles.each do |rn|
                @user.add_role(rn)
        end
        end

        if @user.save
            redirect_to users_path, success: 'User was successfully created.'
        else
            render action: 'new' 
        end
    end
    
    def update
        if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
            params[:user].delete(:password)
            params[:user].delete(:password_confirmation)
        end
        if @user.update(user_params)
            if !@user.roles.empty?
                @user.roles.delete_all
            end

            roles = params[:roles]

            if !roles.blank?
                roles.each do |rn|
                @user.add_role(rn)
            end
            redirect_to user_path, success: 'User was successfully updated.'
        else
            render action: 'edit'
        end
    end

<<<<<<< HEAD
=======
    # def finish_signup
    #     if request.patch? && params[:user]
    #         if @user.update(user_params)
    #             @user.skip_reconfirmation!
    #             sign_in(@user, :bypass => true)
    #             redirect_to @user, notice: 'Your profile was successfully updated.'
    #         else
    #             @show_errors = true
    #         end
    #     end
    # end
>>>>>>> Messed with skip_confirmation, Reverted back to original
    
    def destroy
        if @user.destroy
          redirect_to users_path, success: 'User was successfully deleted!'
        else
          render action: 'index'
        end
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])  
        rescue ActiveRecord::RecordNotFound
        redirect_to(root_url, alert: 'User not found')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :phone, :email, :ic, :password, :password_confirmation)
    end

    
    
end
