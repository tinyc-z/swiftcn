module BaseModel
  extend ActiveSupport::Concern

  included do
    scope :desc, ->(key=:id) { order("#{key} DESC")}
    scope :asc, ->(key=:id) { order("#{key} ASC")}
    delegate :url_helpers, to: 'Rails.application.routes'
  end

end

