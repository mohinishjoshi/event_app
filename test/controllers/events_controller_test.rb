require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get attend_event" do
    get events_attend_event_url
    assert_response :success
  end

  test "should get unattend_event" do
    get events_unattend_event_url
    assert_response :success
  end

end
