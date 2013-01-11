module GoogleHelper

  def google_maps_api_tag
    javascript_include_tag "https://maps.googleapis.com/maps/api/js?key=#{GOOGLE.api_key}&sensor=true"
  end

end
