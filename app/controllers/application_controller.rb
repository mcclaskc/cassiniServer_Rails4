class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Exception, with: lambda { |exception| render_error 500, exception }

  def render_error(status, e)
   p e
  end
end
