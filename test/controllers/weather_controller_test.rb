require "test_helper"

class WeatherControllerTest < ActionDispatch::IntegrationTest
  test "index return a successful response" do
    get "/"
    assert_response :success
  end
  test "search should return successful response" do
    get "/search?address=1125+Goldfinch+Lane+Antioch+IL+60002&num_days=7&commit=Get+Weather"
    assert_response :success
  end
end
