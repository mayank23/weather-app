require "http"

class WeatherController < ApplicationController

  def index
  end

  def search
    @form = WeatherSearchForm.new
    @form.address = params[:address]
    @form.num_days = params[:num_days]

    if @form.valid? && @form.zip_code
      current_timestamp = Time.now.to_i
      @forecast = fetch_forecast(@form.zip_code, @form.num_days)
      @is_stale = is_stale?(current_timestamp, @forecast[:fetch_timestamp])
    else
      @forecast = nil
      @is_stale = nil
    end

  end

  private

  def is_stale?(current_timestamp, fetch_timestamp)
    fetch_timestamp < current_timestamp
  end

  def fetch_forecast(zip_code, num_days)
    Rails.cache.fetch([:weather, zip_code, num_days], expires_in: 30.minutes) do
      response = HTTP.get("https://api.openweathermap.org/data/2.5/forecast/daily", :params => {
        :appid => "bf8c9b1e5ad61b1342374535308b3609",
        :cnt => num_days,
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
      :color => map_temp_to_color(day_info["temp"]["day"])
    } }

    {
      :fetch_timestamp => Time.now.to_i,
      :daily_forecast => daily_forecast
    }
  end

  def map_temp_to_color(temp)
   color = case temp
      when -50..30 then "bg-sky-100"
      when 31..50 then "bg-sky-300"
      when 51..70 then "bg-amber-200"
      when 71..95 then "bg-orange-400"
      when 96..130 then "bg-red-500"
      else ""
   end
   color
  end
end
