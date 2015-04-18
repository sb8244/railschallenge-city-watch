module ActionController
  class Responder
    def json_resource_errors
      { message: resource.errors }
    end

    def api_behavior
      raise MissingRenderer.new(format) unless has_renderer?

      if get? && resource.kind_of?(ActiveRecord::Relation)
        display resource
      elsif get?
        display resource, status: resource.present? ? 200 : 404
      elsif post? || patch?
        display resource, status: :ok, location: api_location
      else
        head :no_content
      end
    end
  end
end
