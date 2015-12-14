module Intacct
  module Support
    module DSL
      extend ActiveSupport::Concern

      included do
        delegate :api_name, :id_attribute, to: :class
      end

      module ClassMethods
        def api_name(name = nil)
          @api_name = (name || self.name.to_s.demodulize.downcase)
        end

        def id_attribute(attr = nil)
          @id_attribute = (attr || "#{self.name.to_s_demodulize.downcase}id") if attr
          @id_attribute
        end
      end
    end
  end
end