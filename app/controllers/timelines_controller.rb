class TimelinesController < ApplicationController
  before_action :authenticate_user!
  def show
    user_ids = current_user.followings.pluck(:id)
    #=> pluck(:id)はuser.idを[1,2]ととることができる
    @articles = Article.where(user_id: user_ids)
  end
end