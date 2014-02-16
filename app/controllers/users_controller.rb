class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_user_manager

  def index
    @users = User.all.group_by{|u| u.role }
  end

  def manage
    params[:users].each do |user|
      unless user[:role].to_s.empty?
        @user = User.find(user[:id])
        @user.role = user[:role]
        @user.save
      end
    end
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'Users successfully updated.' }
      format.json { head :ok }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

  protected

  def require_user_manager
    redirect_to :root and return unless can?(:manage, User)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, :remember_me)
  end
end
