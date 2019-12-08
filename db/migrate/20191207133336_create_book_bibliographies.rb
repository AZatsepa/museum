class CreateBookBibliographies < ActiveRecord::Migration[5.2]
  def change
    create_table :book_bibliographies do |t|
      t.string  :authors,         null: false
      t.string  :title,           null: false
      t.integer :publishing_year, null: false
      t.string  :events_years,    null: false
      t.string  :page,            null: false
      t.text    :annotation,      null: false
      t.boolean :published,       null: false, default: false

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
