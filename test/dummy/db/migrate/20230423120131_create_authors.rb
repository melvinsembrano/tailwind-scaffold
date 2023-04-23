class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.text :description
      t.date :birthday

      t.timestamps
    end
  end
end
