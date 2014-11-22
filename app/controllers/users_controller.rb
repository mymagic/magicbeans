class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource
    def new
        @user = User.new
    end
    
    def index
        @users = User.all
    end
    
    def show
        @user = User.find(params[:id])
        rescue ActiveRecord::RecordNotFound
        redirect_to(root_url, flash.now[:error] => 'Record not found')
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def create
        @user = User.new(user_params)

        if @user.save
            redirect_to @user, success: 'User was successfully created.'
        else
            render action: 'new' 
        end
    end
    
    def update
      if @user.update(user_params)
        redirect_to @user, success: 'User was successfully updated.'
      else
        render action: 'edit'
      end
    end
    
    def destroy
        @user.destroy
        redirect_to users_url
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :phone, :email, :ic, :password, :password_confirmation)
    end
    
end
