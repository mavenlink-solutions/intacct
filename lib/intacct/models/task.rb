module Intacct
  module Models
    class Task < Intacct::Base

      def create_xml(xml)
        xml.taskname attributes.taskname
        xml.projectid attributes.projectid
        xml.pbegindate  {
          xml.year attributes.pbegindate.try(:strftime, "%Y")
          xml.month attributes.pbegindate.try(:strftime, "%m")
          xml.day attributes.pbegindate.try(:strftime, "%d")
        }
        xml.penddate {
          xml.year attributes.penddate.try(:strftime, "%Y")
          xml.month attributes.penddate.try(:strftime, "%m")
          xml.day attributes.penddate.try(:strftime, "%d")
        }
        xml.itemid attributes.itemid
        xml.billable attributes.billable
        xml.taxdescription attributes.taxdescription
        xml.ismilestone attributes.ismilestone
        xml.utilized attributes.utilized
        xml.priority attributes.priority
        xml.taskno attributes.taskno
        xml.taskstatus attributes.taskstatus
        xml.parenttaskname attributes.parenttaskname
        xml.budgetqty attributes.budgetqty
        xml.estqty attributes.estqty

        if attributes.taskresources
          xml.taskresources {
            attributes.taskresources.each do |taskresource|
              xml.employeeid tasresource.employeeid
            end
          }
        end

        if attributes.customfields
          xml.customfields {
            attributes.customfields.each do |customfield|
              xml.customfield {
                xml.customfieldname customfield.name
                xml.customfieldvalue customfield.value
              }
            end
          }
        end
      end

      def update_xml(xml)
        create_xml(xml)
      end

    end
  end
end
