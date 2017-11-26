# Originally, the gem was going to be called "Filterable" which would have made
# this much easier but.... Since it's a concern, I wanted to abide by the
# common suffix.
require 'active_support'

module Filterable
	extend ActiveSupport::Concern

  @@filteron = []

  def self.included(base)
    #base.class_variable_set :@@filteron, []
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

    # filter_on
    # This is run within the Model. It registers the field with the class variable
    # and sets up a scope.
    # TODO: Accept a block to use as the filter method
    def filter_on(field, existing_scope = nil)
      # If the user is providing a scope, we don't want to inadvertently use something broken
      unless existing_scope.nil? then raise unless self.respond_to?(existing_scope.to_sym) end

      filter_field = existing_scope || field_to_scope_name(field)
      # FIXME: There has to be a more elegant way to do this.
      # Register the field with the class var
      class_variable_set(:@@filteron, class_variable_get(:@@filteron) << filter_field)
      # Create the scope if one doesn't exist
      if (existing_scope.nil?)
        scope filter_field, ->(field_arg) { where(field.to_sym => (field_arg)) }
      end
    end

	end
end
