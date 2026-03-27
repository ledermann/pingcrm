InertiaRails.configure do |config|
  config.version = ViteRuby.digest
  config.always_include_errors_hash = true
  config.use_script_element_for_initial_page = true
end
