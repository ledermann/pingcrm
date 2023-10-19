JsRoutes.setup do |config|
  # Setup your JS module system:
  # ESM, CJS, AMD, UMD or nil
  config.module_type = 'ESM'

  config.exclude = [
    # Default Rails routes not required from Inertia.js
    /rails_/,
  ]

  config.compact = true
end
