class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :authorize_post, only: [:show]

  def new
    @post = Post.new
    @posts = current_user.posts
    @published_posts = @posts.where(status: 1)
    @draft_posts = @posts.where(status: 0)
    @unpublished_posts = @posts.where(status: 2)
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if params[:draft].present?
      @post.status = :draft
    else
      @post.status = :published
    end

    if @post.save
      if @post.draft?
        redirect_to post_path(@post.id), notice: '下書きが保存されました。'
      else
        redirect_to post_path(@post.id), notice: '投稿が公開されました。'
      end
    else
      render :new
    end
  end

  def index
    @posts = Post.where(status: :published)
  end

  def show
    @post = Post.find(params[:id])
    @post_detail = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    @posts = current_user.posts
    @published_posts = @posts.where(status: 1)
    @draft_posts = @posts.where(status: 0)
    @unpublished_posts = @posts.where(status: 2)
  end

  def update
    @post = Post.find(params[:id])

    @post.assign_attributes(post_params)

    if params[:draft].present?
      @post.status = :draft
      notice_message = "下書き保存しました。"
      redirect_path = post_path(@post.id)

    elsif params[:unpublished].present?
      @post.status = :unpublished
      notice_message = "非公開にしました。"
      redirect_path = post_path(@post.id)

    else 
      @post.status = :published
      notice_message = "投稿を更新しました。"
      redirect_path = post_path(@post.id)
    end

    if @post.save
       redirect_to post_path(@post.id) , notice: notice_message 
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_path(current_user.id)
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :body, :status)
  end

  def is_matching_login_user
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      redirect_to posts_path
    end
  end

  def authorize_post
    @post = Post.find(params[:id])
    unless @post.published? || current_user == @post.user
      redirect_to posts_path, alert: "この投稿にはアクセス権限がありません。"
    end
  end
end
