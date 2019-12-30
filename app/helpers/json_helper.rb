module JsonHelper
  def error_response(error = nil)
    @success = false
    @error = error
    render 'api/v1/error', layout: "application.json.erb"
  end
end
