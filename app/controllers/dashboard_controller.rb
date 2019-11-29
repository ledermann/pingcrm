class DashboardController < ApplicationController
  def index
    render inertia: 'Dashboard/Index', props: {
    }
  end
end
