require 'digest'

InertiaRails.configure do |config|
  def checksum(dir)
    files = Dir["#{dir}/**/*"].reject { |f| File.directory?(f) }
    content = files.map { |f| File.read(f) }.join
    Digest::MD5.hexdigest(content)
  end

  asset_path = if Rails.env.test?
    Rails.public_path.join('vite-test')
  elsif Rails.env.production?
    Rails.public_path.join('vite')
  elsif Rails.env.development?
    Rails.root.join('app', 'vite-dev')
  end

  config.version = checksum(asset_path)
end
