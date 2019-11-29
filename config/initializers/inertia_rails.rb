require 'digest'

def checksum(dir)
  files = Dir["#{dir}/**/*"].reject { |f| File.directory?(f) }
  content = files.map { |f| File.read(f) }.join
  Digest::MD5.hexdigest(content).to_s
end

InertiaRails.configure do |config|
  if Rails.env.production?
    asset_path = Rails.root.join('public', 'packs').to_s

    config.version = checksum(asset_path)
  end
end
