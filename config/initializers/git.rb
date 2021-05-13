Rails.configuration.x.git.commit_sha  = (ENV.fetch('COMMIT_SHA') { `git rev-parse HEAD` }).first(7)
Rails.configuration.x.git.commit_time = Time.zone.parse(
  ENV.fetch('COMMIT_TIME') { `git show -s --format=%cI` }
)
