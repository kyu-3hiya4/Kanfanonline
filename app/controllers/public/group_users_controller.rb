class Public::GroupUsersController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @group_user = current_user.group_users.new(group_id: params[:group_id])
    @group_user.status = GroupUser.statuses[:pending]
   
    if @group_user.save
        redirect_to group_path(params[:group_id]), notice: "グループへ参加申請しました。"
    else
        redirect_to group_path(params[:group_id]), notice: "グループへ参加申請できませんでした。" #エラー時のリダイレクト先
    end
  end
  
  def update
    @group_user = GroupUser.find(params[:id])

    if params[:approval].present?
      @group_user.status = GroupUser.statuses[:approval]
      notice_message = "グループへの参加を承認しました。"
    elsif params[:cancel].present?
      @group_user.status = GroupUser.statuses[:cancel]
      notice_message = "グループへの参加を拒否しました。"
    end

    if @group_user.save
      redirect_to group_group_users_path(params[:group_id]), notice: notice_message
    else
      redirect_to group_group_users_path(params[:group_id]), alert: "更新に失敗しました。"
    end
   end

  def index
    @group_users = GroupUser.where(group_id: params[:group_id], status: 0)
  end

  def destroy
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
    group_user.destroy
    redirect_to group_path(params[:group_id]), notice: "グループメンバーから削除しました。"
  end

  private
  
   def group_user_params
    params.require(:group_user).permit(:satus)
   end
end
