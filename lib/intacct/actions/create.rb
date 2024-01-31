module Intacct
  module Actions
    class Create < Base
      def request(_options)
        if legacy?
          Intacct::XmlRequest.build_xml(client, action) do |xml|
            xml.function(controlid: "1") do
              xml.send(klass.legacy_create_name) do
                klass.create_xml(xml)
              end
            end
          end
        else
          Intacct::XmlRequest.build_xml(client, action) do |xml|
            xml.function(controlid: "1") do
              xml.create do
                xml.send(klass.api_name) do
                  klass.create_xml(xml)
                end
              end
            end
          end
        end
      end

      def response_body
        raw = @response.at("//result/data/#{klass.api_name.downcase}")
        return unless raw

        Utils.instance.downcase_keys(Hash.from_xml(raw.to_xml)[klass.api_name.downcase])
      end

      def list_type
        nil
      end

      module Helper
        def create(options = {})
          response = Intacct::Actions::Create.new(client, self, "create", **options).perform

          @errors = response.errors
          @raw_response = response.raw_response

          if response.success?
            attributes.recordno = response.body["recordno"] unless response.body.nil?
            true
          else
            false
          end
        end
      end
    end
  end
end
