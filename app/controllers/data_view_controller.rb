class DataViewController < ApplicationController
	
  def home
    
  end

  def vendor_suggest
    @q = params[:q].upcase
    return render :nothing => true if @q.nil?
    
    @db = CouchRest.database!("http://texasgov.info:5984/tceq_data")
    @matches = @db.view('vendor/year_month_day', {
      :group_level => 1,
      :startkey => [@q],
      :endkey => [@q + "Z"],
      :limit => 10
    })
    
    render :text => @matches['rows'].map { |row| row['key'] }.join('')
  end

  def category_total
    @db = CouchRest.database!("http://texasgov.info:5984/tceq_data")
    @totals = @db.view('comp_obj_category/year_month', {
      :group_level => 1
    })
    return render :json => @totals if(params[:raw])
    
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

  def category_by_year
    @db = CouchRest.database!("http://texasgov.info:5984/tceq_data")
    @by_year = @db.view('comp_obj_category/year_month', {
      :group_level => 2,
      :reverse => true
    })
    return render :json => @by_year if(params[:raw])
    
    @points = {}
    @months = %w{ Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec }
    @years = []
    
    for doc in @by_year['rows']
      @cat = doc['key'][0]
      @years.push(doc['key'][1]) if not @years.include? doc['key'][1]
      @points[@cat] ||= []
      @points[@cat].push(doc['value'].to_f / 1000000)
    end
    @years = @years.map { |y| y.to_s }
    
    @data = []
    for cat, pset in @points
      @data.push({
        'name' => cat,
        'data' => pset
      })
    end
    
    @options = {
      :chart => {
        :defaultSeriesType => 'line'
      },
      :title => { :text => 'Dollars Spent per Comptroller Object Category per Year' },
      :xAxis => {
        :categories => @years,
        :title => { :text => 'Year' }
      },
      :yAxis => {
        :title => { :text => 'Dollars Spent (Millions)' }
      },
      :series => @data
    }
    
    @response = {
      :status => 'ok',
      :options => @options
    }
    
    render :json => @response
  end
  
  def category_by_month
    @year = params[:year]
    @cats = params[:cats]
    if @year.nil? or not [2007,2008,2009].include? @year.to_i
      @response = { :status => 'bad year' }
      return render :json => @response
    end
    @year = @year.to_i
    
    @db = CouchRest.database!("http://texasgov.info:5984/tceq_data")
    @by_year = @db.view('comp_obj_category/year_month', {
      :group_level => 3,
      :reverse => true
    })
    return render :json => @by_year if(params[:raw])
    
    @points = {}
    @months = %w{ Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec }
    
    for doc in @by_year['rows']
      next if @year != doc['key'][1]
      @cat = doc['key'][0]
      @points[@cat] ||= []
      @points[@cat].push(doc['value'].to_f / 1000000)
    end
    
    @data = []
    for cat, pset in @points
      next if not @cats.include? cat
      @data.push({
        'name' => cat,
        'data' => pset
      })
    end
    
    @options = {
      :chart => {
        :defaultSeriesType => 'line'
      },
      :title => { :text => 'Dollars Spent per Comptroller Object Category per Month for %d' % @year },
      :xAxis => {
        :categories => @months,
        :title => { :text => 'Month (%d)' % @year }
      },
      :yAxis => {
        :title => { :text => 'Dollars Spent (Millions)' }
      },
      :series => @data
    }
    
    @response = {
      :status => 'ok',
      :options => @options
    }
    
    render :json => @response
  end

  def vendor_by_year
    @vendors = params[:vendors].map { |v| v + "\n" }
    
    @db = CouchRest.database!("http://texasgov.info:5984/tceq_data")
    
    @points = {}
    @years = []
    
    @raw = []
    
    for vendor in @vendors
      @by_year = @db.view('vendor/year_month_day', {
        :group_level => 2,
        :startkey => [vendor, 0],
        :endkey => [vendor, 9999]
      })
      puts @by_year
      @raw.push({ :key => [vendor], :value => @by_year['rows'] }) if(params[:raw])
      
      for doc in @by_year['rows']
        @vendor = doc['key'][0]
        @year = doc['key'][1]
        @years.push(@year) if not @years.include? @year
        @points[@vendor] ||= {}
        @points[@vendor][@year] = doc['value'].to_f
      end
    end
    if(params[:raw])
      return render :json => {
        :rows => @raw
      }
    end
    
    @years = @years.sort
    
    @data = []
    for vendor, pset in @points
      data = []
      for year in @years
        data.push pset[year] || 0
      end
      @data.push({
        'name' => vendor,
        'data' => data
      })
    end
    
    @options = {
      :chart => {
        :defaultSeriesType => 'column'
      },
      :title => { :text => 'Dollars Spent for selected Vendors per Year' },
      :xAxis => {
        :categories => @years,
        :title => { :text => 'Year' }
      },
      :yAxis => {
        :title => { :text => 'Dollars Spent' }
      },
      :series => @data,
      :tooltip => {
        
      }
    }
    @formatter = %q{
      function(){
        // TODO: javascript formatter!
      }
    }
    @response = {
      :status => 'ok',
      :options => @options,
      :formatter => @formatter
    }
    
    render :json => @response
  end

end
