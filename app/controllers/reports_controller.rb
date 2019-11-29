class ReportsController < ApplicationController
  def index
    render inertia: 'Reports/Index', props: {}
  end
end
