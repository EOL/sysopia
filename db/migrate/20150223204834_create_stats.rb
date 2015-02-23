class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :timestamp, nil: false, index: true
      t.references :comp, nil: false, index: true
      t.float :load_one
      t.float :load_five
      t.float :load_fifteen
      t.integer :cpu_user # percent
      t.integer :cpu_system # percent
      t.integer :cpu_busy # percent
      t.integer :cpu_wait # percent
      t.float :io_read # MB/sec
      t.float :io_write # MB/sec
      t.integer :swap_used # MB
      t.float :swap_in # MB/sec
      t.float :swap_out # MB/sec
      t.float :interrups # per sec
      t.float :context_switches # per sec
      t.float :memory_taken # percent
      t.integer :processes_waiting
      t.integer :processes_iowaiting
    end
  end
end
