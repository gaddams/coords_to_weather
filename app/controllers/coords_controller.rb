require 'open-uri'
require 'json'

class CoordsController < ApplicationController

def fetch_weather
    @address_1 = params[:address]
    #@address_1 = "milpitas,ca"
    @url_safe_address = URI.encode(@address_1)
    #@url_safe_address = params[:address]

    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@url_safe_address}&sensor=true"
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    results = parsed_data["results"]
    first = results[0]
    geometry = first["geometry"]
    location = geometry["location"]
    @latitude = location["lat"]
    @longitude = location["lng"]

    # @latitude = 82.0538387
    # @longitude = -77.67721
    your_api_key = "c9e9c0126467bcf2c8c7020fbb669030"

    # Your code goes here.
    url = "https://api.forecast.io/forecast/#{your_api_key}/#{@latitude},#{@longitude}"
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    currently = parsed_data["currently"]
    @temperature = currently["temperature"]

    if parsed_data["minutely"]
        minutely = parsed_data["minutely"]
        @minutely_summary = minutely["summary"]
    else
         @minutely_summary = "This data doesn't exist"
    end

    hourly = parsed_data["hourly"]
    @hourly_summary = hourly["summary"]
    daily = parsed_data["daily"]
    @daily_summary = daily["summary"]
  end
end
