class CreateRecords < ActiveRecord::Migration
  def self.up
    create_table :tceq_2008_v2 do |t|
      t.integer :fiscal_year
      t.datetime :trans_date
      t.string :agency_name
      t.string :comp_obj_name
      t.string :obj_type
      t.string :comp_obj_cat_type
      t.decimal :trans_amt
      t.string :trans_obj_conf_indicator
      t.string :vendor_payee_disp_name

      t.timestamps
    end
  end

  def self.down
    # drop_table :tceq_2008_v2
  end
end
