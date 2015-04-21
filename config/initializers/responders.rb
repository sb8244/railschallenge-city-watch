# Override responder to allow for graceful 404 responses
module ActionController
  class Responder
    def json_resource_errors
      { message: resource.errors }
    end

    def api_behavior
      fail MissingRenderer, format unless has_renderer?

      return display resource, status: :ok, location: api_location if update?
      return http_get_api_behavior if get?

      head :no_content
    end

    private

    def relation_response?
      resource.is_a?(ActiveRecord::Relation)
    end

    def update?
      post? || patch?
    end

    def resource_status
      resource.present? ? 200 : 404
    end

    def http_get_api_behavior
      if relation_response?
        display resource
      else
        display resource, status: resource_status
      end
    end
  end
end
