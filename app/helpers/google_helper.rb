module GoogleHelper

  def google_maps_api_tag
    javascript_include_tag "https://maps.googleapis.com/maps/api/js?key=#{google_api_key}&sensor=true"
  end

  def google_api_key
    'AIzaSyDnMkrIGwuDCrXC50JoVRc7ogYq5STh3BQ'
  end

end
