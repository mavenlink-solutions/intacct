module Intacct
  module Actions
    class Update < Base
      def request(options = {})
        legacy? ? generate_legacy_request(options) : generate_request(options)
      end

      def response_body
        nil
      end

      def list_type
        nil
      end

      def response_errors
        raw = @response.at("//result/errormessage") || @response.at("//errormessage")
        return unless raw

        [Hash.from_xml(raw.to_xml)["errormessage"]["error"]].flatten
      end

      module Helper
        def update(options = {})
          response = Intacct::Actions::Update.new(client, self, "update", options).perform

          @errors = response.errors
          @raw_response = response.raw_response

          response.success?
        end
      end

      private

      def generate_legacy_request(options)
        Intacct::XmlRequest.build_xml(client, action) do |xml|
          xml.function(controlid: "1") do
            xml.send(klass.legacy_update_name, key: klass.public_send(klass.id_attribute)) do
              update_supports_override? ? klass.update_xml(xml, options) : klass.update_xml(xml)
            end
          end
        end
      end

      def generate_request(options)
        Intacct::XmlRequest.build_xml(client, action) do |xml|
          xml.function(controlid: "1") do
            xml.update do
              xml.send(klass.api_name) do
                update_supports_override? ? klass.update_xml(xml, options) : klass.update_xml(xml)
              end
            end
          end
        end
      end

      def update_supports_override?
        klass.method(:update_xml).arity != 1
      end
    end
  end
end
