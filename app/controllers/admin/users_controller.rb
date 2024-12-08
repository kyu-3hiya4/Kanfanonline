class Admin::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    # @posts = @user.posts
  end

  def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
  end
end
