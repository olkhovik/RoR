class NotificationMailer < ApplicationMailer

  def moderation_success_notification(post)
    @post = post
    @user = @post.user
    mail(to: @user.email, subject: 'Ваш пост прошел модерацию' )
  end

  def post_to_draft_notification(post)
    @post = post
    @user = @post.user
    mail(to: @user.email, subject: 'Ваш пост перемещен в черновики' )
  end



  def comment_notification(user, post, comment)
    @user = user
    @post = post
    @comment = comment


    mail(to: user.email, subject: 'Новый комментарий на ваш пост')
  end
end
