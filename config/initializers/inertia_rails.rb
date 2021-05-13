require 'digest'

def checksum(dir)
  files = Dir["#{dir}/**/*"].reject { |f| File.directory?(f) }
  content = files.map { |f| File.read(f) }.join
  Digest::MD5.hexdigest(content)
end

InertiaRails.configure do |config|
  asset_path = if Rails.env.test?
    Rails.root.join('public', 'packs-test')
  elsif Rails.env.production?
    Rails.root.join('public', 'packs')
  elsif Rails.env.development?
    Rails.root.join('app', 'packs')
  end

  config.version = checksum(asset_path)
end
