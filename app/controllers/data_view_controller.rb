class DataViewController < ApplicationController
	
  def home
    
  end

  def total
    @db = CouchRest.database!("http://texasgov.info:5984/tceq_data")
    @totals = @db.view('comp_obj_category/year_month?group_level=1')
    @data = []
    @cats = []
    for doc in @totals['rows']
      @cat = doc['key'][0]
      @cats.push(@cat) if not @cats.include? @cat
      
      @data.push({
        'name' => doc['key'][0],
        'data' => [doc['value'].to_i]
      })
    end
    render :json => @data
  end

  def by_year
    @db = CouchRest.database!("http://texasgov.info:5984/tceq_data")
    @by_year = @db.view('comp_obj_category/year_month?group_level=2&reverse=true')
    @points = {}
    @months = %w{ Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec }
    
    for doc in @by_year['rows']
      @cat = doc['key'][0]
      puts doc['key'][1]
      @points[@cat] ||= []
      @points[@cat].push(doc['value'].to_i)
    end
    
    @data = []
    for cat, pset in @points
      @data.push({
        'name' => cat,
        'data' => pset
      })
    end
    
    render :json => @data
  end

end
