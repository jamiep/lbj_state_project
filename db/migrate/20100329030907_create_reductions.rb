class CreateReductions < ActiveRecord::Migration
  def self.up
    create_table :reductions do |t|
      t.string :type
      t.decimal :value

      t.timestamps
    end
  end

  def self.down
    drop_table :reductions
  end
end
