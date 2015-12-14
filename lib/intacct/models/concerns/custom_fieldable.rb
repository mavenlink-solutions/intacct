module Intacct
  module Models
    module Concerns
      module CustomFieldable
        extend ActiveSupport::Concern

        included do
          field :customfields
        end
      end
    end
  end
end