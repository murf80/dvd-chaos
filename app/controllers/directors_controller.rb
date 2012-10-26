class DirectorsController < ApplicationController
  # GET /directors
  # GET /directors.json
  def index

    params = @_request.filtered_parameters
    if params['search_by'] and params['search_value']
      @search_by = params['search_by']
      @search_value = params['search_value']
      case @search_by
        when "name"
          # TODO This is needs to escape the inputs, not a big deal for this project though
          @directors = Director.all(:conditions => [ @search_by + " LIKE ?", "%" + @search_value + "%"])
        when "age"
          # TODO: don't have time to get to this one now
        when "dvds"
          # TODO This is hideous.  Definitely a better way to do it...another day
          @directors = Array.new
          @dvds = Dvd.all(:include => :director, :conditions => [ "name LIKE ?", "%" + @search_value + "%"])
          @dvds.each do |dvd|
            @directors << dvd.director
          end
        else
          @directors = Director.all
      end
    else
      @directors = Director.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @directors }
    end
  end

  # GET /directors/1
  # GET /directors/1.json
  def show
    @director = Director.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @director }
    end
  end

  # GET /directors/new
  # GET /directors/new.json
  def new
    @director = Director.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @director }
    end
  end

  # GET /directors/1/edit
  def edit
    @director = Director.find(params[:id])
  end

  # POST /directors
  # POST /directors.json
  def create

    # process the dob first
    params[:director][:dob] = DateSelectHelper.to_datetime(params[:selected_date])

    @director = Director.new(params[:director])

    # check for new dvds
    @dvd_ids = params[:dvds] ? params[:dvds]["ids"] : nil
    if @dvd_ids
      @dvd_ids.shift
      @director.dvds <<  Dvd.find(@dvd_ids)
    end

    respond_to do |format|
      if @director.save
        format.html { redirect_to @director, notice: 'Director was successfully created.' }
        format.json { render json: @director, status: :created, location: @director }
      else
        format.html { render action: "new" }
        format.json { render json: @director.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /directors/1
  # PUT /directors/1.json
  def update
    @director = Director.find(params[:id])

    # process the dob first
    params[:director][:dob] = DateSelectHelper.to_datetime(params[:selected_date])

    respond_to do |format|
      if @director.update_attributes(params[:director])

        # check for new dvds
        @dvd_ids = params[:dvds] ? params[:dvds]["ids"] : nil
        if @dvd_ids
          @dvd_ids.shift
          @director.dvds = Array.new
          @director.dvds <<  Dvd.find(@dvd_ids)
        else
          @director.dvds = nil
        end

        format.html { redirect_to @director, notice: 'Director was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @director.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /directors/1
  # DELETE /directors/1.json
  def destroy
    @director = Director.find(params[:id])
    @director.destroy

    respond_to do |format|
      format.html { redirect_to directors_url }
      format.json { head :no_content }
    end
  end
end
