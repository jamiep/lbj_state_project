class ReductionsController < ApplicationController
  # GET /reductions
  # GET /reductions.xml
  def index
    @reductions = Reduction.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reductions }
    end
  end

  # GET /reductions/1
  # GET /reductions/1.xml
  def show
    @reduction = Reduction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reduction }
    end
  end

  # GET /reductions/new
  # GET /reductions/new.xml
  def new
    @reduction = Reduction.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reduction }
    end
  end

  # GET /reductions/1/edit
  def edit
    @reduction = Reduction.find(params[:id])
  end

  # POST /reductions
  # POST /reductions.xml
  def create
    @reduction = Reduction.new(params[:reduction])

    respond_to do |format|
      if @reduction.save
        flash[:notice] = 'Reduction was successfully created.'
        format.html { redirect_to(@reduction) }
        format.xml  { render :xml => @reduction, :status => :created, :location => @reduction }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reduction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reductions/1
  # PUT /reductions/1.xml
  def update
    @reduction = Reduction.find(params[:id])

    respond_to do |format|
      if @reduction.update_attributes(params[:reduction])
        flash[:notice] = 'Reduction was successfully updated.'
        format.html { redirect_to(@reduction) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reduction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reductions/1
  # DELETE /reductions/1.xml
  def destroy
    @reduction = Reduction.find(params[:id])
    @reduction.destroy

    respond_to do |format|
      format.html { redirect_to(reductions_url) }
      format.xml  { head :ok }
    end
  end
end
