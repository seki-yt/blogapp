# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        # has_many :　　　　はmodelを紐付けることができる（user_modelとarticle_modelを紐付け）modelは複数系
        # dependent: :destroyはユーザーが退会したら記事を全部消す
   has_many :articles, dependent: :destroy
   has_many :likes, dependent: :destroy
   has_many :favorite_articles, through: :likes, source: :article

   has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
   has_many :followings, through: :following_relationships, source: :following

   has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
   has_many :followers, through: :follower_relationships, source: :follower

   has_one :profile, dependent: :destroy

   delegate :birthday, :age, :gender, to: :profile, allow_nil: true
   # => これを定義するとしたのbirthdayとgenderは使わなくてよくなる


  #コードが長くなったりわかりにくい場合modelにメゾットを書いてわかりやすくする必要がある
  # exists?はテーブルにレコードにあるかないかだけ判断できる
   def has_written?(article)
      articles.exists?(id: article.id)
   end

   def has_liked?(article)
     likes.exists?(article_id: article.id)
   end
     

   #seki1020.gmail.com
   def display_name
    #  if profile && profile.nickname
    #  profile.nickname || self.email.split('@').first
    #  => ['seki1020', 'gmail.com']
    #  end

     profile&.nickname || self.email.split('@').first
   end

   def follow!(user)
    user_id = get_user_id(user)

    following_relationships.create!(following_id: user_id )
   end

   def unfollow!(user)
    user_id = get_user_id(user)

    relation = following_relationships.find_by!(following_id: user_id)
    relation.destroy!
   end

   def has_followed?(user)
    following_relationships.exists?(following_id: user.id)
   end

    #  def birthday
    #    profile&.birthday
    #  end

    #  def gender
    #    profile&.gender
    # end

   def prepare_profile
     profile || build_profile
   end

    def avatar_image
      if profile&.avatar&.attached?
        profile.avatar
      else
        'default-avatar.png'
      end
    end

    private
    def get_user_id(user)
      if user.is_a?(User)
        user.id
      else
        user
      end
    end
    #=>
end
