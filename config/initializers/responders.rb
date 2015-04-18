module ActionController
  class Responder
    def json_resource_errors
      { message: resource.errors }
    end

    def api_behavior
      raise MissingRenderer.new(format) unless has_renderer?

      if get?
        display resource
      elsif post?
        display resource, :status => :ok, :location => api_location
      else
        head :no_content
      end
    end
  end
end
