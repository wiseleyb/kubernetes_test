class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.timestamps
    end

    10.times do |i|
      User.create(name: "User #{i+1}")
    end
  end
end
