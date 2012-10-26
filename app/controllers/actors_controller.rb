class ActorsController < ApplicationController

  include DateSelectHelper

  # GET /actors
  # GET /actors.json
  def index

    params = @_request.filtered_parameters
    if params['search_by'] and params['search_value']
      @search_by = params['search_by']
      @search_value = params['search_value']
      case @search_by
        when "name"
          # TODO This is needs to escape the inputs, not a big deal for this project though
          @actors = Actor.all(:conditions => [ @search_by + " LIKE ?", "%" + @search_value + "%"])
        when "age"
          # TODO: don't have time to get to this one now
        when "dvds"
          # TODO This is hideous.  Definitely a better way to do it...another day
          @actors = Array.new
          @dvds = Dvd.all(:include => :actors, :conditions => [ "name LIKE ?", "%" + @search_value + "%"])
          @dvds.each do |dvd|
            @actors << dvd.actors
          end
          @actors = @actors.flatten
        else
          @actors = Actor.all
      end
    else
      @actors = Actor.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @actors }
    end
  end

  # GET /actors/1
  # GET /actors/1.json
  def show
    @actor = Actor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @actor }
    end
  end

  # GET /actors/new
  # GET /actors/new.json
  def new
    @actor = Actor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @actor }
    end
  end

  # GET /actors/1/edit
  def edit
    @actor = Actor.find(params[:id])
  end

  # POST /actors
  # POST /actors.json
  def create

    # process the dob
    params[:actor][:dob] = DateSelectHelper.to_datetime(params[:selected_date])

    @actor = Actor.new(params[:actor])

    # check for new dvds
    @dvd_ids = params[:dvds] ? params[:dvds]["ids"] : nil
    if @dvd_ids
      @dvd_ids.shift
      @actor.dvds <<  Dvd.find(@dvd_ids)
    end

    respond_to do |format|
      if @actor.save
        format.html { redirect_to @actor, notice: 'Actor was successfully created.' }
        format.json { render json: @actor, status: :created, location: @actor }
      else
        format.html { render action: "new" }
        format.json { render json: @actor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /actors/1
  # PUT /actors/1.json
  def update
    @actor = Actor.find(params[:id])

    # process the dob
    params[:actor][:dob] = DateSelectHelper.to_datetime(params[:selected_date])

    respond_to do |format|
      if @actor.update_attributes(params[:actor])

        # check for new dvds
        @dvd_ids = params[:dvds] ? params[:dvds]["ids"] : nil
        if @dvd_ids
          @dvd_ids.shift
          @actor.dvds = Array.new
          @actor.dvds <<  Dvd.find(@dvd_ids)
        else
          @actor.dvds = nil
        end
      end

      if @actor.save
        format.html { redirect_to @actor, notice: 'Actor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @actor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actors/1
  # DELETE /actors/1.json
  def destroy
    @actor = Actor.find(params[:id])
    @actor.destroy

    respond_to do |format|
      format.html { redirect_to actors_url }
      format.json { head :no_content }
    end
  end
end
