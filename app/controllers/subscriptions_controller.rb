class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    current_user.subscribe_to(@post)
    redirect_to @post,
                notice: 'Вы успешно подписаны на обновления'
  end

  def destroy
    subscription = Subscription.find(params[:id])
    subscription.destroy if current_user.id == subscription.user_id
    redirect_to subscription.post,
                notice: 'Вы отписались от обновлений'
  end
end
