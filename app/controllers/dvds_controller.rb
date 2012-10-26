class DvdsController < ApplicationController

  include DateSelectHelper

  # GET /dvds
  # GET /dvds.json
  def index
    @dvds = Dvd.all

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
