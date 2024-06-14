class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :nome
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.boolean :isAdmin, default: false
      t.boolean :isActive, default: true
      t.string :photo
      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
