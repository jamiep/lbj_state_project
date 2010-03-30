# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100329030907) do

  create_table "agency_code", :id => false, :force => true do |t|
    t.integer "agency_code"
    t.string  "agency_name"
  end

  create_table "comp_obj", :id => false, :force => true do |t|
    t.integer "obj_code"
    t.string  "obj_name"
    t.string  "comp_obj_cat_code"
  end

  create_table "comp_obj_cat_code", :id => false, :force => true do |t|
    t.string "category_code"
    t.string "category_name"
  end

  create_table "reductions", :force => true do |t|
    t.string   "type"
    t.integer  "value",      :limit => 10, :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

# Could not dump table "tceq_2008_RES" because of following StandardError
#   Unknown type 'year(4)' for column 'fiscal_year'

# Could not dump table "tceq_2008_original" because of following StandardError
#   Unknown type 'year(4)' for column 'fiscal_year'

# Could not dump table "tceq_2008_v2" because of following StandardError
#   Unknown type 'year(4)' for column 'fiscal_year'

# Could not dump table "tceq_2009_RES" because of following StandardError
#   Unknown type 'year(4)' for column 'fiscal_year'

# Could not dump table "tceq_2009_original" because of following StandardError
#   Unknown type 'year(4)' for column 'fiscal_year'

# Could not dump table "tceq_2009_v2" because of following StandardError
#   Unknown type 'year(4)' for column 'fiscal_year'

  create_table "trans_obj_conf_indicator", :id => false, :force => true do |t|
    t.string "conf_ind_code"
    t.string "conf_ind_desc"
  end

end
