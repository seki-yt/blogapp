# == Schema Information
#
# Table name: profiles
#
#  id           :integer          not null, primary key
#  birthday     :date
#  gender       :integer
#  introduction :text
#  nickname     :string
#  subscribed   :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
class Profile < ApplicationRecord
  enum gender: { male: 0, famale: 1, other: 2 }
  belongs_to :user
  has_one_attached :avatar
  # => avatarというデータをここで取得できるようになる

  def age
    return '不明' unless birthday.present?
    #birthdayが入力されてないとき不明と表示
    years = Time.zone.now.year - birthday.year
    days = Time.zone.now.yday - birthday.yday
    # => Time.zone.now.現在の時間が取れる
    # => Time.zone.now.year 現在の年がわかる
    # =>  yday 一年の始まりから何日たったかわかる

    if days < 0
      "#{years - 1}歳"
    else
      "#{years}歳"
    end
  end
end
