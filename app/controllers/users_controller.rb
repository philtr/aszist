class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
    if can? :manage, User
      @users = User.all.group_by{|u| u.role }
    else
      redirect_to :root
    end
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
      if @user.update_attributes(params[:user])
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

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, :remember_me)
  end
end
