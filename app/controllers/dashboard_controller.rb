class DashboardController < ApplicationController
  def index
    render inertia: 'Dashboard/Index', props: {
      git: {
        commit_time: ENV['COMMIT_TIME'] || Time.current.to_s,
        commit_sha:  ENV['COMMIT_SHA'] ? ENV['COMMIT_SHA'].first(7) : 'development',
        commit_url:  ENV['COMMIT_SHA'] ? "https://github.com/ledermann/pingcrm/commit/#{ENV['COMMIT_SHA']}" : 'https://github.com/ledermann/pingcrm'
      }
    }
  end
end
