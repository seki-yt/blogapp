# frozen_string_literal: true

module UserDecorator

  def display_name
    #  if profile && profile.nickname
    #  profile.nickname || self.email.split('@').first
    #  => ['seki1020', 'gmail.com']
    #  end

     profile&.nickname || self.email.split('@').first
   end

   def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end

end
