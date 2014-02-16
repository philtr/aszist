class ProfilesController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(profile_params)
        format.html { redirect_to users_path, notice: 'Profile updated successfully.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  def profile_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end
