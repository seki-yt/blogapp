class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      #ここにカラムを追加しターミナルに rails db:migarateを実行する
      t.references :user, null: false
      t.string :title, null: false
      t.text :content, null: false
      # =>null: falseはデータベース場にこの値がないと保存しませんと誓約することができる
      t.timestamps
    end
  end
end
