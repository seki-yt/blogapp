# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Article < ApplicationRecord
    validates :title, presence: true
    #lendth文字の長さの指定するときに使う
    #minimumは最低文字数、maximumは最高文字数
    validates :title, length: { minimum: 2, maximum: 100 }
    #formatは特定の文字を含ませたい時などに使う
    validates :title, format: { with: /\A(?!\@)/ }

    validates :content, presence: true
    validates :content, length: { minimum: 10}
    #uniquenessは全く同じ内容がどうかチェックし保存させない
    validates :content, uniqueness: true

    #validateは独自のvalidatesを作るときに使う
    #メゾット名を書いてprivateに実行するメゾットをかく
    validate :validate_title_and_content_length

    def display_created_at
        I18n.l(self.created_at, format: :default)
    end

    private
    def validate_title_and_content_length
        char_count = self.title.length + self.content.length
        unless char_count > 100
            errors.add(:content, '100文字で以上で！！')
        end
    end
end

