module ApplicationHelper

  def google_maps_api_tag
    javascript_include_tag 'https://maps.googleapis.com/maps/api/js?key=AIzaSyDnMkrIGwuDCrXC50JoVRc7ogYq5STh3BQ&sensor=true'
  end
end
