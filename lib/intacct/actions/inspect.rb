module Intacct
  module Actions
    class Inspect < Base
      LOOKUP_OBJECT = %w[Intacct::Models::SalesDocument].freeze

      def request(options)
        Intacct::XmlRequest.build_xml(client, action) do |xml|
          xml.function(controlid: "1") do
            if klass.to_s.in?(LOOKUP_OBJECT)
              docparid = options.try(:[], :docparid).presence
              docparid = "<docparid>#{docparid}</docparid>" if docparid.present?

              xml << <<-XML
                <lookup>
                  <object>#{klass.api_name.upcase}</object>
                  #{docparid}
                </lookup>
              XML
            else
              if options[:detail]
                xml << <<-XML
                  <inspect detail="1">
                    <object>#{klass.api_name.upcase}</object>
                  </inspect>
                XML
              else
                xml << <<-XML
                  <inspect detail="0">
                    <object>#{klass.api_name.upcase}</object>
                  </inspect>
                XML
              end
            end
          end
        end
      end

      def response_body
        raw =  @response.at("//result/data/Type/Fields")
        return unless raw

        Hash.from_xml(raw.to_xml)["Fields"]["Field"]
      end

      def list_type
        raw =  @response.at("//result/data/Type")
        return unless raw

        Hash.from_xml(raw.to_xml)["Type"]["Name"].try(:downcase)
      end

      module Helper
        extend ActiveSupport::Concern

        module ClassMethods
          def inspect_object(client, options = {})
            response = Intacct::Actions::Inspect.new(client, self, "inspect", options).perform

            response.body
          end
        end
      end
    end
  end
end

module Nokogiri
  module XML
    class Builder
      def inspect(*args); end
    end
  end
end
