class CreateZombies < ActiveRecord::Migration[5.2]
  def change
    create_table :zombies do |t|
      t.string :name
      t.integer :age
      t.text :bio
      t.boolean :rotting
      t.string :email

      t.timestamps
    end
  end
end
