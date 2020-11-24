class ProfilesController < ApplicationController
  before_action :authenticate_user!
  # before_action => show, editなど実行する前に行うアクション
  # authenticate_user! => ログインしてないとshowもeditもできない

  def show
    @profile = current_user.profile
    # current_user.profile => 取得できるのはuser.rbにhas_one :profileと書いたからできる
  end

  def edit
  #   if current_user.profile.present?
  #     @profile = current_user.profile
  #   else
  #     @profile = current_user.build_profile
  #   # => has_oneの場合はbuild_profileとかく
  #   end 
  # 上のを簡単にかく方法
    @profile = current_user.prepare_profile
  end

  def update
    @profile = current_user.prepare_profile
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to profile_path, notice: 'プロフィール更新！'
    else
      flash.now[:error] = '更新できませんでした'
      render :editなど実行する前に行うアクション
    end
  end

  private
  def profile_params
    params.require(:profile).permit(
      :nickname,
      :introduction,
      :gender,
      :birthday,
      :subscribed,
      :avatar
    )
  end

end