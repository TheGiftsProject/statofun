module GoogleHelper

  def google_maps_api_tag
    params = {
        :key    => GOOGLE.api_key,
        :sensor => true
    }
    javascript_include_tag "https://maps.googleapis.com/maps/api/js?#{params.to_query}"
  end

end
