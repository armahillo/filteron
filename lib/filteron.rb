require "filteron/version"
require "filteron/railtie" if defined?(Rails)
require "filterable"

module Filteron
  # Accepts string or symbol arguments, returns a symbol
  def field_to_scope_name field_name
    ("_" + field_name.to_s).to_sym
  end
end
