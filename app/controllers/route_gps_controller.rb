class RouteGpsController < ApplicationController
  before_action :set_route_gp, only: [:show, :edit, :update, :destroy]

  # GET /route_gps
  # GET /route_gps.json
  def index
    @route_gps = RouteGp.all
  end

  # GET /route_gps/1
  # GET /route_gps/1.json
  def show
  end

  # GET /route_gps/new
  def new
    @route_gp = RouteGp.new
  end

  # GET /route_gps/1/edit
  def edit
  end

  # POST /route_gps
  # POST /route_gps.json
  def create
    @route_gp = RouteGp.new(route_gp_params)

    respond_to do |format|
      if @route_gp.save
        format.html { redirect_to @route_gp, notice: 'Route gp was successfully created.' }
        format.json { render :show, status: :created, location: @route_gp }
      else
        format.html { render :new }
        format.json { render json: @route_gp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /route_gps/1
  # PATCH/PUT /route_gps/1.json
  def update
    respond_to do |format|
      if @route_gp.update(route_gp_params)
        format.html { redirect_to @route_gp, notice: 'Route gp was successfully updated.' }
        format.json { render :show, status: :ok, location: @route_gp }
      else
        format.html { render :edit }
        format.json { render json: @route_gp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /route_gps/1
  # DELETE /route_gps/1.json
  def destroy
    @route_gp.destroy
    respond_to do |format|
      format.html { redirect_to route_gps_url, notice: 'Route gp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route_gp
      @route_gp = RouteGp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def route_gp_params
      params.require(:route_gp).permit(:mission_id, :time, :lat, :lon, :alt)
    end
end
