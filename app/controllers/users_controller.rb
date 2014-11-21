class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    
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

        respond_to do |format|
          if @user.save
            redirect_to @user, success: 'User was successfully created.'
          else
            render action: 'new' 
          end
        end
    end
    
    def update
        respond_to do |format|
          if @user.update(user_params)
            redirect_to @user, success: 'User was successfully updated.' 
          else
            render action: 'edit' 
          end
        end
    end
    
    def destroy
        @user.destroy
            respond_to do |format|
              redirect_to users_url
            end
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :age, :email)
    end
    
end
