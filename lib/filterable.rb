# Originally, the gem was going to be called "Filterable" which would have made
# this much easier but.... Since it's a concern, I wanted to abide by the
# common suffix.
require 'active_support'

module Filterable
	extend ActiveSupport::Concern

  def self.included(base)
    base.class_variable_set :@@filteron, []
  end

	module ClassMethods
    # Many thanks to Justin Weiss, who unknowingly wrote this method (`filter`)
    # that inspired this Concern and ultimately grew into this project.
    # http://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/
		def filter(filtering_params)
			results = self.where(nil)
			filtering_params.each do |key, value|
				results = results.public_send(key, value) if value.present?
			end
			results
		end


	end
end
