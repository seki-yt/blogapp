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


  #コードが長くなったりわかりにくい場合modelにメゾットを書いてわかりやすくする必要がある
  # exists?はテーブルにレコードにあるかないかだけ判断できる
   def has_written?(article)
      articles.exists?(id: article.id)
   end
     

   #seki1020.gmail.com
   def display_name
     self.email.split('@').first
     # => ['seki1020', 'gmail.com']
   end
end
