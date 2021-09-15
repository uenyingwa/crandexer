class CreatePackages < ActiveRecord::Migration[6.1]
  def change
    create_table :packages do |t|
      t.jsonb :author
      t.text :description
      t.jsonb :maintainer
      t.string :name, null: false
      t.datetime :published_at
      t.string :title
      t.string :version, null: false

      t.timestamps
    end

    add_index :packages, :name
    add_index :packages, :version
  end
end
