require 'filteron/view_helpers'

module Filteron
  class Railtie < Rails::Railtie
    initializer "filteron.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end