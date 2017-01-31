require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    @clean_address = @street_address.gsub(' ', '+')
    @lat_long_data = JSON.parse(open("http://maps.googleapis.com/maps/api/geocode/json?address="+@clean_address).read)

    @latitude = @lat_long_data["results"][0]["geometry"]["location"]["lat"].to_s

    @longitude = @lat_long_data["results"][0]["geometry"]["location"]["lng"].to_s

    @parsed_data = JSON.parse(open("https://api.darksky.net/forecast/2a508a104d69bb5490f40b81b256208a/" + @latitude + "," +@longitude).read)

    @current_temperature = @parsed_data["currently"]["temperature"]

    @current_summary = @parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = @parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = @parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = @parsed_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
