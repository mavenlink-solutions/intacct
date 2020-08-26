module Intacct
  module Actions
    class Delete < Base
      def request(options)
        raise "Must specify a value for `key` in the options hash." unless options[:key]

        Intacct::XmlRequest.build_xml(client, action) do |xml|
          xml.function(controlid: "1") do
            xml.delete do
              xml.object klass.api_name
              xml.keys options[:key]
            end
          end
        end
      end

      def response_body
        nil
      end

      def list_type
        nil
      end

      module Helper
        extend ActiveSupport::Concern

        def delete(options = {})
          options.merge! key: recordno

          success = self.class.delete(client, options)

          if success
            attributes.recordno = nil
            true
          else
            false
          end
        end

        module ClassMethods
          def delete(client, options = {})
            response = Intacct::Actions::Delete.new(client, self, "delete", options).perform

            response.success?
          end
        end
      end
    end
  end
end
