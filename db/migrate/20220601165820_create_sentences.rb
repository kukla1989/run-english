class CreateSentences < ActiveRecord::Migration[7.0]
  def change
    create_table :sentences do |t|
      t.text :sentence_eng
      t.text :sentence_ua
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
