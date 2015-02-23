class CreateComps < ActiveRecord::Migration
  def change
    create_table :comps do |t|
      t.string :sensu_name, nil: false, index: :unique
      t.string :ipaddress
      t.integer :cpunum
      t.integer :total_memory
    end
  end
end
