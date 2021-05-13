class DashboardController < ApplicationController
  def index
    render inertia: 'Dashboard/Index', props: {
      git: {
        commit_time: Rails.configuration.x.git.commit_time,
        commit_sha:  Rails.configuration.x.git.commit_sha,
        commit_url:  "https://github.com/ledermann/pingcrm/commits/#{Rails.configuration.x.git.commit_sha}"
      }
    }
  end
end
