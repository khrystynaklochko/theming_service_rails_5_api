class CreateThemes < ActiveRecord::Migration[5.0]
  def change
    create_table :themes do |t|
      t.string   :name
      t.text     :style
      t.string     :url
      t.integer  :user_id
      t.timestamps
    end
    add_index :themes, :name, unique: true
  end
end
