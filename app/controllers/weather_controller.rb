require "http"

class WeatherController < ApplicationController
  def index
  end

  def search
    address = params[:address]
    zip_code = get_zip_code_from_address(address)

    current_timestamp = Time.now.to_i
    forecast = fetch_forecast(zip_code)

    @daily_forecast = forecast[:daily_forecast]
    @fetch_datetime = Time.at(forecast[:fetch_timestamp]).to_datetime
    @is_stale = is_stale?(current_timestamp, forecast[:fetch_timestamp])
  end

  private

  def get_zip_code_from_address(address)
    Geocoder.search(address)&.first&.data["address"]["postcode"]
  end

  def is_stale?(current_timestamp, fetch_timestamp)
    fetch_timestamp < current_timestamp
  end

  def fetch_forecast(zip_code)
    Rails.cache.fetch([:weather, zip_code], expires_in: 30.minutes) do
      response = HTTP.get("https://api.openweathermap.org/data/2.5/forecast/daily", :params => {
        :appid => "bf8c9b1e5ad61b1342374535308b3609",
        :cnt => "2",
        :zip => zip_code,
        :units => "imperial",
      })
      parse(response)
    end
  end

  def parse(response)
    daily_forecast = response.parse["list"].map{ |day_info| {
      :date => Time.at(day_info["dt"]).to_date,
      :temperature => {
        :current =>  day_info["temp"]["day"],
        :low =>  day_info["temp"]["min"],
        :high =>  day_info["temp"]["max"],
      },
      :humidity => day_info["humidity"],
      :description => day_info["weather"][0]["description"],
    } }

    {
      :fetch_timestamp => Time.now.to_i,
      :daily_forecast => daily_forecast
    }
  end
end
