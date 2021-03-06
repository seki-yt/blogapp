# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord

    has_one_attached :eyecatch
    validates :title, presence: true
    # =>titleがないと保存しませんよ
    # =>ApplicationRecordは保存しないがSQLは保存してもいいよって状態

    
    validates :title, length: { minimum: 2, maximum: 100 }
    # =>lendth文字の長さの指定するときに使う
    # =>minimumは最低文字数、maximumは最高文字数
    
    validates :title, format: { with: /\A(?!\@)/ }
    # =>formatは特定の文字を含ませたい時などに使う

    validates :content, presence: true
    #validates :content, length: { minimum: 10}
    #uniquenessは全く同じ内容がどうかチェックし保存させない
    #validates :content, uniqueness: true

    #validateは独自のvalidatesを作るときに使う
    #メゾット名を書いてprivateに実行するメゾットをかく
    #validate :validate_title_and_content_length

    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_rich_text :content


    #belongs_to :　　　はarticleとuserは紐づいてることを表す
    belongs_to :user

    # => 上のhas_manyでlikesと表示しているためlikesが取れる

    # private
    # def validate_title_and_content_length
    #     char_count = self.title.length + self.content.length
    #     unless char_count > 100
    #         errors.add(:content, '100文字で以上で！！')
    #     end
    # end
end

