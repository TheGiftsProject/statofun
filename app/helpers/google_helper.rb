module GoogleHelper

  def google_maps_api_tag
    params = {
        :key    => GOOGLE.api_key,
        :sensor => true
    }
    javascript_include_tag "https://maps.googleapis.com/maps/api/js?#{params.to_query}"
  end

  def google_static_map(ltd, lng, zoom = 14, width = 640, height = 640)
    params = {
        :key      => GOOGLE.api_key,
        :sensor   => false,
        :zoom     => zoom,
        :size     => "#{width}x#{height}",
        :markers  => "color:green|#{ltd},#{lng}",
        :language => 'he'
    }
    "http://maps.googleapis.com/maps/api/staticmap?center=#{ltd},#{lng}&#{params.to_query}"
  end

end
