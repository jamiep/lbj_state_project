class CouchController < ApplicationController
	require "rubygems"
	require "couchrest"
	
  def list
  	@db = CouchRest.database!("http://texasgov.info:5984/somedatabase")
  	response = @db.save_doc({:key => 'value', 'another key' => 'another value'})
  	@doc = @db.get(response['id'])
  end

end
