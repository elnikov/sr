class CreateLeagues < ActiveRecord::Migration[6.1]
  def change
    create_table :leagues do |t|
      t.string :name_en, null: false, uniq: true
      t.string :name_ru, null: false, uniq: true
      t.integer :sex, limit: 1
      t.string :slug, null: false, uniq: true
      t.references :sport, null: false, foreign_key: true
      t.references :bookmaker, null: false, foreign_key: true
      t.index :name_en
      t.index :name_ru
      t.index :slug

      t.timestamps
    end
  end
end
