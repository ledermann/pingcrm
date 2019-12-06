class ExceptionsController < ActionController::Base # rubocop:disable Rails/ApplicationController
  def show
    render inertia: 'Error', props: {
      status: request.path_info[1..-1].to_i
    }
  end
end
