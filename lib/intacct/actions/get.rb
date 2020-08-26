module Intacct
  module Actions
    class Get < Base
      def request(options)
        raise 'Must specify a value for `key` in the options hash.' unless options[:key]

        Intacct::XmlRequest.build_xml(client, action) do |xml|
          xml.function(controlid: 'f4') do
            xml.get(object: klass.api_name, key: options[:key]) do
              if options[:fields]
                xml.fields do
                  fields.each do |field|
                    xml.field field.to_s
                  end
                end
              end
            end
          end
        end
      end

      def response_body
        raw = @response.at("//result/data/#{list_type}")
        return unless raw

        Hash.from_xml(raw.to_xml)[list_type]
      end

      def list_type
        @response.at('//result/listtype').content
      end

      module Helper
        extend ActiveSupport::Concern

        module ClassMethods
          def get(client, options = {})
            response = Intacct::Actions::Get.new(client, self, 'get', options).perform

            new(client, response.body) if response.success?
          end
        end
      end
    end
  end
end
