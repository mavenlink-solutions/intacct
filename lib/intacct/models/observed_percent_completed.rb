module Intacct
  module Models
    class ObservedPercentCompleted < Intacct::Base

      api_name "OBSPCTCOMPLETED"

      def create_xml(xml)
        xml.type      attributes.type
        xml.taskkey   attributes.taskkey
        xml.ASOFDATE  attributes.asofdate
        xml.percent   attributes.percent
        xml.note      attributes.note
      end

      def update_xml(xml)
        create_xml(xml)
      end

    end
  end
end
