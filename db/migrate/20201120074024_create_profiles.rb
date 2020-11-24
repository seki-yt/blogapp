class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false
      t.string :nickname
      #長文を入れる際にtext
      t.text :introduction
      t.integer :gender
      t.date :birthday
      t.boolean :subscribed, default: false
      t.timestamps
    end
  end
end
