class DvdsController < ApplicationController

  include DateSelectHelper

  # GET /dvds
  # GET /dvds.json
  def index

    params = @_request.filtered_parameters
    if params['search_by'] and params['search_value']
      @search_by = params['search_by']
      @search_value = params['search_value']
      case @search_by
        when "name"
          # TODO This is needs to escape the inputs, not a big deal for this project though
          @dvds = Dvd.all(:conditions => [ @search_by + " LIKE ?", "%" + @search_value + "%"])
        when "actor"
          # TODO This is hideous.  Definitely a better way to do it...another day
          @dvds = Array.new
          @actors = Actor.all(:include => :dvds, :conditions => [ "name LIKE ?", "%" + @search_value + "%"])
          @actors.each do |actor|
            @dvds << actor.dvds
          end
          @dvds = @dvds.flatten
        when "director"
          # TODO This is hideous.  Definitely a better way to do it...another day
          @dvds = Array.new
          @directors = Director.all(:include => :dvds, :conditions => [ "name LIKE ?", "%" + @search_value + "%"])
          @directors.each do |director|
            @dvds << director.dvds
          end
          @dvds = @dvds.flatten
        else
          @dvds = Dvd.all
      end
    else
      @dvds = Dvd.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dvds }
    end
  end

  # GET /dvds/1
  # GET /dvds/1.json
  def show
    @dvd = Dvd.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dvd }
    end
  end

  # GET /dvds/new
  # GET /dvds/new.json
  def new
    @dvd = Dvd.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dvd }
    end
  end

  # GET /dvds/1/edit
  def edit
    @dvd = Dvd.find(params[:id])
  end

  # POST /dvds
  # POST /dvds.json
  def create

    # process the release date first
    params[:dvd][:release_date] = DateSelectHelper.to_datetime(params[:selected_date])

    @dvd = Dvd.new(params[:dvd])

    if params[:director] and params[:director]["id"]
      @dvd.director = Director.find(params[:director]["id"])
    end

    @actor_ids = params[:actors] ? params[:actors]["ids"] : nil
    if @actor_ids
      @actor_ids.shift
      @dvd.actors <<  Actor.find(@actor_ids)
    end

    respond_to do |format|
      if @dvd.save
        format.html { redirect_to @dvd, notice: 'Dvd was successfully created.' }
        format.json { render json: @dvd, status: :created, location: @dvd }
      else
        format.html { render action: "new" }
        format.json { render json: @dvd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dvds/1
  # PUT /dvds/1.json
  def update
    @dvd = Dvd.find(params[:id])

    # process the release date first
    params[:dvd][:release_date] = DateSelectHelper.to_datetime(params[:selected_date])

    respond_to do |format|
      if @dvd.update_attributes(params[:dvd])

        if params[:director] and params[:director]["id"]
          @dvd.director = Director.find(params[:director]["id"])
        else
          @dvd.director = nil
        end
        @actor_ids = params[:actors] ? params[:actors]["ids"] : nil
        if @actor_ids
          @actor_ids.shift
          @dvd.actors = Array.new
          @dvd.actors <<  Actor.find(@actor_ids)
        else
          @dvd.actors = nil
        end
      end

      if @dvd.save
        format.html { redirect_to @dvd, notice: 'Dvd was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dvd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dvds/1
  # DELETE /dvds/1.json
  def destroy
    @dvd = Dvd.find(params[:id])
    @dvd.destroy

    respond_to do |format|
      format.html { redirect_to dvds_url }
      format.json { head :no_content }
    end
  end
end
