# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

class ActiveRecord::Base
  cattr_accessor :skip_elasticsearch_callbacks
end

ActiveRecord::Base.skip_elasticsearch_callbacks = false
