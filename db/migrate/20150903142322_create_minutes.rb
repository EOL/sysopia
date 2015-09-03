class CreateMinutes < ActiveRecord::Migration
  def change
    create_table :minutes do |t|
      t.integer :minutes, index: :unique
    end
  end
end
