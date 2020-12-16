class RemoveContentFromArticles < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :content, :text
  end

  # def up
  #   remove_column :articles, :content
  # end

  # => migrationを実行したときにのみ実行される

  # def down
  #   add_column :articles, :content, text
  # end

  # => rollbackされたときのみ実行される
end
