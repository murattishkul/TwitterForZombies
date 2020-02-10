class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.text :status
      t.references :zombie, foreign_key: true

      t.timestamps
    end
  end
end
