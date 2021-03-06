require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    @clean_address = @street_address.gsub(' ', '+')
    @parsed_data = JSON.parse(open("http://maps.googleapis.com/maps/api/geocode/json?address="+@clean_address).read)

    @latitude = @parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = @parsed_data["results"][0]["geometry"]["location"]["lng"]

    render("geocoding/street_to_coords.html.erb")
  end
end
