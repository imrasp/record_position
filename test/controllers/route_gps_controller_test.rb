require 'test_helper'

class RouteGpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @route_gp = route_gps(:one)
  end

  test "should get index" do
    get route_gps_url
    assert_response :success
  end

  test "should get new" do
    get new_route_gp_url
    assert_response :success
  end

  test "should create route_gp" do
    assert_difference('RouteGp.count') do
      post route_gps_url, params: { route_gp: { alt: @route_gp.alt, lat: @route_gp.lat, lon: @route_gp.lon, mission_id: @route_gp.mission_id, time: @route_gp.time } }
    end

    assert_redirected_to route_gp_url(RouteGp.last)
  end

  test "should show route_gp" do
    get route_gp_url(@route_gp)
    assert_response :success
  end

  test "should get edit" do
    get edit_route_gp_url(@route_gp)
    assert_response :success
  end

  test "should update route_gp" do
    patch route_gp_url(@route_gp), params: { route_gp: { alt: @route_gp.alt, lat: @route_gp.lat, lon: @route_gp.lon, mission_id: @route_gp.mission_id, time: @route_gp.time } }
    assert_redirected_to route_gp_url(@route_gp)
  end

  test "should destroy route_gp" do
    assert_difference('RouteGp.count', -1) do
      delete route_gp_url(@route_gp)
    end

    assert_redirected_to route_gps_url
  end
end
