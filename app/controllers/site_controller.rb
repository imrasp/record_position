class SiteController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'json'

  $text = "null"

  def index
    # $text += "#{request.body.read}"
    @lastmission = Mission.last()
    if !@lastmission.nil?

      @drone = Aircraft.where(id:@lastmission.aircraft_id).last()
      @apath = RouteGp.where(mission_id: @lastmission.id)
      @geojson = Array.new

      @apath.each do |apath|
        @geojson << {
            type: 'Feature',
            geometry: {
                type: 'Point',
                coordinates: [apath.lat, apath.lon]
            },
            properties: {
                title: 'Mapbox',
                description: 'Test'
            }
        }
      end
      @lastlat= @apath.last().lat
      @lastlon= @apath.last().lon
    end

    respond_to do |format|
      format.html
      format.json {render json: @geojson} # respond with the created JSON object
    end
  end

  def stream_position
    data_hash = JSON.parse(request.body.read)
    puts data_hash['time']
    puts data_hash['lat']
    puts data_hash['lon']
    puts data_hash['alt']

    @mission = Mission.where(name: data_hash['mission_id'])

    puts "misison name : " + @mission.name.to_s
    @position = RouteGp.new(:mission_id => @mission.mission_id,
                            :timestamp => data_hash['time'],
                            :lat => data_hash['lat'],
                            :lon => data_hash['lon'],
                            :alt => data_hash['alt'])
    @position.save!

    respond_to do |format|
      format.html {redirect_to site_index_path}
    end
  end

  def stream_mission_info
    data_hash = JSON.parse(request.body.read)
    puts data_hash['mission_id']
    puts data_hash['drone']

    @aircraft = Aircraft.where(name: data_hash['drone'])
    @mission = Mission.new(name: data_hash['mission_id'],
                           aircraft_id: @aircraft.id,
                           starttime: data_hash['startat'])
    @mission.save!

    respond_to do |format|
      format.html {redirect_to site_index_path}
    end
  end

  def stream_mission_endtime

  end

end
