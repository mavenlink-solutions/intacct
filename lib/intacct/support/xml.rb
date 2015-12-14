module Intacct
  module Support
    module XML
      extend ActiveSupport::Concern

      BLACKLISTED_FIELDS = %i(whenmodified)

      def to_xml(xml, action = :create)
        transform_attributes!(action)

        writable_attributes(action).each do |key, value|
          attributes_to_xml(xml, key, value)
        end
        xml
      end

      private

      def writable_attributes(action)
        self.attributes.select { |key, value| key.to_sym.in? writable_field_names(action) }
      end

      def transform_attributes!(action)
        dynamic_fields(action).each { |field, options|
          dynamic = options.delete(:dynamic)

          attributes[field] = if dynamic.is_a?(Proc)
                                dynamic.call(attributes[field])
                              elsif dynamic.is_a?(String) || dynamic.is_a?(Symbol)
                                self.send(dynamic)
                              else
                                raise 'Must provide a callable object or method name'
                              end
        }
      end

      def writable_fields(action)
        fields = action == :create ? create_fields : update_fields
        fields = fields
        fields.reject { |field, options| field.in?(self.class.read_only_fields) || field.in?(BLACKLISTED_FIELDS) }
      end

      def writable_field_names(action)
        writable_fields(action).keys
      end

      def dynamic_fields(action)
        writable_fields(action).select { |field, options| options[:dynamic].present? }
      end

      def create_fields
        self.class.fields.reject { |field, options| options[:only_update] }
      end

      def update_fields
        self.class.fields.reject { |field, options| options[:only_create] }
      end

      def attributes_to_xml(xml, key, value)
        if value.is_a?(Hash)
          xml.send(key) {
            value.each do |k,v|
              attributes_to_xml(xml, k, v)
            end
          }
        elsif value.is_a?(Intacct::Base)
          xml.send(key) {
            value.attributes.each do |k, v|
              attributes_to_xml(xml, k, v)
            end
          }
        elsif value.is_a?(Array)
          xml.send(key) {
            value.each do |val|
              xml.send(key.to_s.singularize) {
                val.each do |k,v|
                  attributes_to_xml(xml, k, v)
                end
              }

            end
          }
        else
          xml.send(key, value)
        end
      end

    end
  end
end
