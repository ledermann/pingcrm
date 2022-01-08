namespace :webpacker do
  desc 'Change config/webpacker.yml compile parameter to false'
  task disable_compile_in_test: :environment do
    config_path = Rails.root.join('config', 'webpacker.yml')
    content = YAML.load(config_path.read, aliases: true) # rubocop:disable Security/YAMLLoad
    new_content = content.deep_merge({ 'test' => { 'compile' => false, 'cache_manifest' => true } })
    new_yaml = YAML.dump(new_content, { line_width: -1 })
    config_path.write(new_yaml)
  end
end
