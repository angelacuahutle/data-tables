class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.string :href
      t.string :description
      t.string :extended
      t.string :meta
      t.string :hash_value
      t.boolean :shared
      t.boolean :toread
      t.string :tags, array: true, default: []

      t.timestamps
    end
  end
end
