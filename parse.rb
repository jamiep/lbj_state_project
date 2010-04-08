git commit -C ORIG_HEAD

require 'time'
require 'rubygems'
require 'couchrest'

# initialize remote couchdb connection
@db = CouchRest.database!("http://texasgov.info:5984/tceq_data")

aFile = File.new("./lbj_data/tceq_2008_for_couchDB", "r")
bulk = []
while line = aFile.gets
  #puts line
  if (line != "")
    entryArr = line.split(/\|/)
    fiscal_year = entryArr[0].to_i
    trans_date = Time.parse(entryArr[1]).to_i
    agency_name = entryArr[2]
    comp_obj_name = entryArr[3]
    obj_type = entryArr[4]
    comp_obj_cat_type = entryArr[5]
    trans_amt = entryArr[6].to_i
    trans_obj_conf_indicator = entryArr[7]
    if trans_obj_conf_indicator.downcase.include? 'no confidential'
      trans_obj_conf_indicator = "no"
    elsif trans_obj_conf_indicator.downcase.include? 'some confidential'
      trans_obj_conf_indicator = "some"
    elsif trans_obj_conf_indicator.downcase.include? 'confidential'
      trans_obj_conf_indicator = "yes"
    else
      trans_obj_conf_indicator = "unknown"
    end
    vendor_payee_disp_name =  entryArr[8]
    #puts entryArr
    new_doc = {
      'fiscal_year' => fiscal_year,
      'trans_date' => trans_date,
      'agency_name' => agency_name,
      'comp_obj_name' => comp_obj_name,
      'obj_type' => obj_type,
      'comp_obj_category' => comp_obj_cat_type,
      'trans_amt' => trans_amt,
      'confidential' => trans_obj_conf_indicator,
      'vendor_payee_disp_name' => vendor_payee_disp_name
    }
    
    bulk.push(new_doc)
    puts "  > Size: "+bulk.size.to_s
  	#puts bulk
  end

  if bulk.size == 1000 # save in bulks of 1000 for efficiency
    response = @db.bulk_save(bulk)
    puts response
    bulk = []
  end

end 
#catch the rest of the documents <1000
response = @db.bulk_save(bulk)
puts response
aFile.close