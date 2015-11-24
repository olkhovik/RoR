class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :publish, :to_draft, :to_moderation]
  before_action :owner_check, only: [:edit, :update, :destroy, :publish, :to_draft, :to_moderation]
  before_action :admin_check, only: [:publish]

  def index
    @posts = Post.reverse_order.published.all
  end

  def my
    @posts = current_user.posts.all
    render :index
  end

  def moderation
    @posts = current_user.posts.moderation.all
    render :index
  end

  def drafts
    @posts = current_user.posts.drafts.all
    render :index
  end

  def show
    @comment = Comment.new
    @comments = @post.comments

  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def publish
    @post.published!
    redirect_to @post, notice: 'Пост опубликован'
    send_moderate_success_notification(@post)
  end


  def to_moderation
    @post.moderation!
    redirect_to @post, notice: 'Пост отправлен на модерацию'
  end

  def to_draft
    @post.draft!
    send_post_to_draft_notification(@post)
    redirect_to @post, notice: 'Пост сохранен в черновики'
  end

  def destroy
    @post.destroy
      redirect_to posts_url, notice: 'Post was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, category_ids: [], comment_ids: [])
    end

    def admin_check
      unless current_user.admin?
        redirect_to posts_url, notice: 'У вас нет прав на выполнение этого действия'
      end
    end

  def owner_check
      @post = Post.find(params[:id])
      unless current_user.owner_of?(@post)
        redirect_to posts_url, notice: 'You do not have permission to perform this action!'
      end
  end

#убрать в model
  def send_moderate_success_notification(post)
      NotificationMailer.moderation_success_notification(post).deliver_now
    end

  def send_post_to_draft_notification(post)
    NotificationMailer.post_to_draft_notification(post).deliver_now
  end
end
