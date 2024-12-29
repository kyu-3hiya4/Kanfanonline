class Admin::DashboardsController < ApplicationController
  layout 'admin'
  
  def index
      @users = User.all
      @comments = Comment.all
      @groups = Group.all
  end
end
