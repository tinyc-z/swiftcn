Kaminari.configure do |config|
  config.default_per_page = Settings.PER_PAGE
  # config.max_per_page = nil
  config.window = 1
  config.outer_window = 0
  config.left = 1
  config.right = 0
  # config.page_method_name = :page
  # config.param_name = :page
end
