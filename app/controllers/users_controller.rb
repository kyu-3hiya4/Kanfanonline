class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  @user = User.find(params[:id])
  @user.update(user_params)
  redirect_to user_path(current_user.id) 
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "退会処理が完了しました。"
    redirect_to new_user_registration_path
  end
  
  private

   def user_params
    params.require(:user).permit(:name, :email)
    end
  end
