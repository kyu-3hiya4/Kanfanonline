class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to group_path(@group.id)
    else
      render 'new'
     end
    end

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find_by(id: params[:id])
    if @group.update(group_params)
       redirect_to group_path(@group.id) 

    else
      render :edit
    end
  end

  private
   def group_params
    params.require(:group).permit(:name, :theme)
   end

   def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
   end
end
