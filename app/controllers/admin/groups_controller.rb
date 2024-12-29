class Admin::GroupsController < ApplicationController
  layout 'admin'
 def index
  @groups = Group.all
 end

 def show
  @group = Group.find(params[:id])
 end

 def destroy
  @group = Group.find(params[:id])
  @group.destroy
  redirect_to admin_groups_path, notice: 'グループを削除しました。'
end
end
