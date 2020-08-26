module Intacct
  module Models
    class Timesheet < Intacct::Base
      def create_xml(xml)
        xml.employeeid attributes.employeeid
        xml.BEGINDATE attributes.begindate.try(:strftime, '%m/%d/%Y')
        xml.description attributes.description
        xml.state attributes.state
        xml.lines attributes.lines

        if attributes.customfields
          xml.customfields do
            attributes.customfields.each do |customfield|
              xml.customfield do
                xml.customfieldname customfield[:customfieldname]
                xml.customfieldvalue customfield[:customfieldvalue]
              end
            end
          end
        end

        xml.timesheetentries do
          attributes.timesheetentries.each do |timesheetentry|
            xml.timesheetentry do
              xml.lineno timesheetentry[:lineno]
              xml.projectid timesheetentry[:projectid]
              xml.taskkey timesheetentry[:taskkey]
              xml.customerid timesheetentry[:customerid]
              xml.itemid timesheetentry[:itemid]
              xml.ENTRYDATE timesheetentry[:entrydate].try(:strftime, '%m/%d/%Y')
              xml.qty timesheetentry[:qty]
              xml.description timesheetentry[:description]
              xml.notes timesheetentry[:notes]
              xml.state timesheetentry[:state]
              xml.locationid timesheetentry[:locationid]
              xml.departmentid timesheetentry[:departmentid]
              xml.timetype timesheetentry[:timetype]
              xml.billable timesheetentry[:billable]

              xml.vendorid timesheetentry[:vendorid]
              xml.classid timesheetentry[:classid]

              xml.extbillrate timesheetentry[:extbillrate]
              xml.extcostrate timesheetentry[:extcostrate]

              if timesheetentry[:customfields]
                xml.customfields do
                  timesheetentry[:customfields].each do |customfield|
                    xml.customfield do
                      xml.customfieldname customfield[:customfieldname]
                      xml.customfieldvalue customfield[:customfieldvalue]
                    end
                  end
                end
              end
            end
          end
        end
      end

      def update_xml(xml)
        create_xml(xml)
      end
    end
  end
end
