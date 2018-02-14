class SiteController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'json'

  $text = "null"

  def index
    $text += "#{request.body.read}"

    @apath = Route.all
    @geojson = Array.new

    @apath.each do |apath|
      @geojson << {
          type: 'Feature',
          geometry: {
              type: 'Point',
              coordinates: [apath.lon, apath.lat]
          },
          properties: {
              title: 'Mapbox',
              description: 'Test'

          }
      }
    end

    @geojson.each do |geo|
      puts geo
    end

    respond_to do |format|
      format.html
      format.json { render json: @geojson }  # respond with the created JSON object
    end
  end

  def stream_position
    data_hash = JSON.parse(request.body.read)
    puts data_hash['time']
    puts data_hash['lat']
    puts data_hash['lon']
    puts data_hash['alt']

    @mission = Mission.find(1)

    puts "misison name : " + @mission.name.to_s
    @position = Route.new(:mission_id => @mission.mission_id,
        :timestamp => data_hash['time'],
        :lat => data_hash['lat'],
        :lon => data_hash['lon'],
        :alt => data_hash['alt'])

    @position.save!
    puts "position id is  : " + @position.id.to_s
    respond_to do |format|
        format.html { redirect_to site_index_path}
    end
  end

end
