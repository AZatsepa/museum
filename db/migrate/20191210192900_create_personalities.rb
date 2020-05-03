class CreatePersonalities < ActiveRecord::Migration[5.2]
  def change
    create_table :personalities do |t|
      t.string :name, null: false
      t.string :life_years
      t.text :information, null: false
      t.string :definition
      t.boolean :published, default: false
      t.boolean :locked, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
