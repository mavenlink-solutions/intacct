module Intacct
  module Support
    module Sublist
      extend ActiveSupport::Concern
      delegate :list_fields, to: :class

      def initialize(client, attributes = {})
        if list_fields.any?
          @incoming_attributes = attributes.dup.with_indifferent_access

          super.tap {
            list_fields.each { |field, options|
              @attributes[field] = [sublist_attributes(field)].flatten.map{ |attrs| options[:class].new(client, attrs) }
            }
          }
          remove_instance_variable :@incoming_attributes
        end
      end

      def has_sublist?
        true
      end

      def sublist_attributes(field)
        @incoming_attributes[field][list_name(field)]
      rescue
        {}
      end

      def list_name(field)
        field.downcase.to_s.singularize
      end

      module ClassMethods
        def list_fields
          fields.select { |field, options| options[:list] }
        end
      end
    end
  end
end