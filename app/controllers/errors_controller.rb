class ErrorsController < ApplicationController
  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

  def server_error
    raise Exception, 'This is an example exception'
  end
end
