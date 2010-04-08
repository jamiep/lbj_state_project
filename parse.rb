require 'rubygems'
require 'couchrest'


aFile = File.new("./lbj_data/test_data", "r")
while line = aFile.gets
   #puts line
   if (line != "")
   	entryArr = line.split(/\|/)
		fiscal_year = entryArr[0]
		trans_date = entryArr[1]
		agency_name = entryArr[2]
		comp_obj_name = entryArr[3]
		obj_type = entryArr[4]
		comp_obj_cat_type = entryArr[5]
		trans_amt = entryArr[6]
		trans_obj_conf_indicator = entryArr[7]
		if trans_obj_conf_indicator.downcase.include? 'no confidential'
			trans_obj_conf_indicator = "no"
		elsif trans_obj_conf_indicator.downcase.include? 'some confidential'
			trans_obj_conf_indicator = "some"
		else
			trans_obj_conf_indicator = "yes"
		end
		vendor_payee_disp_name =  entryArr[8]
		new_doc = {
			'fiscal_year' => fiscal_year,
			'trans_date' => trans_date,
			'agency_name' => agency_name,
			'comp_obj_name' => comp_obj_name,
			'obj_type' => obj_type,
			'comp_obj_cat_type' => comp_obj_cat_type,
			'trans_amt' => trans_amt,
			'confidential' => trans_obj_conf_indicator,
			'vendor_payee_disp_name' => vendor_payee_disp_name
		}
		end
		
	end 

aFile.close