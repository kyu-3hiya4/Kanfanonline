class Public::GroupUsersController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @group_user = current_user.group_users.new(group_id: params[:group_id])

    if params[:pending].present?
      @group_user.status = :pending
    else
      @group_user.status = :approval
    end

    if @group_user.save
      if @group_user.pending?
        redirect_to request.referer, notice: "グループへ参加申請しました。"
      else
        redirect_to group_group_users_path(group_id: params[:group_id]), notice: "グループへの参加を承認しました。"
      end
    else
      redirect_to group_path
    end
  end
  
  def update
    @group_user = current_user.group_users.find_by(group_id: params[:group_id])
    @group_user.assign_attributes(group_user_params)

    if params[:pending].present?
      @group_user.status = :pending
      notice_message = "グループへ参加申請を行いました。"
      redirect_path = group_group_users_path(group_id: params[:group_id])
    elsif params[:cancel].present?
      @group_user.status = :cancel
      notice_message = "グループへの参加を拒否しました。"
      redirect_path = group_path
    else
      @group_user.status = :approval
      notice_message = "グループへの参加を承認しました。"
      redirect_path = group_users_path(group_id: params[:group_id])
    end

    if @group_user.save
      redirect_to redirect_path, notice: notice_message
    end
   end

  def index
    @group_users = GroupUser.all
  end

  def destroy
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
    group_user.destroy
    redirect_to request.referer
  end

  private
  
   def group_user_params
    params.require(:group_user).permit(:satus)
   end
end
