module Intacct
  module Models
    class Task < Intacct::Base
      CREATE_KEYS = %i[taskname
                       projectid
                       taskid
                       pbegindate
                       penddate
                       itemid
                       billable
                       taskdescription
                       ismilestone
                       utilized
                       priority
                       taskno
                       taskstatus
                       parentkey
                       parenttaskname
                       budgetqty
                       estqty
                       timetype
                       obspercentcomplete
                       taskresources
                       customfields
                       classid
                       supdocid
                       dependentonkey
                       dependentonname].freeze
      UPDATE_KEYS = %i[taskname
                       projectid
                       pbegindate
                       penddate
                       itemid
                       billable
                       taskdescription
                       ismilestone
                       utilized
                       priority
                       taskno
                       taskstatus
                       parentkey
                       parenttaskname
                       budgetqty
                       estqty
                       timetype
                       obspercentcomplete
                       taskresources
                       customfields
                       classid
                       dependentonkey
                       dependentonname].freeze

      def create_xml(xml)
        xml.TASKNAME attributes.taskname
        xml.PROJECTID attributes.projectid
        xml.TASKID attributes.taskid if attributes.taskid.present?
        xml.PBEGINDATE format_date(attributes.pbegindate) if attributes.pbegindate.present?
        xml.PENDDATE format_date(attributes.penddate) if attributes.penddate.present?
        xml.ITEMID attributes.itemid if attributes.itemid.present?
        xml.BILLABLE attributes.billable if attributes.billable.present?
        xml.TASKDESCRIPTION attributes.taskdescription if attributes.taskdescription.present?
        xml.ISMILESTONE attributes.ismilestone if attributes.ismilestone.present?
        xml.UTILIZED attributes.utilized if attributes.utilized.present?
        xml.PRIORITY attributes.priority if attributes.priority.present?
        xml.TASKNO attributes.taskno if attributes.taskno.present?
        xml.TASKSTATUS attributes.taskstatus if attributes.taskstatus.present?
        xml.PARENTKEY attributes.parentkey if attributes.parentkey.present?
        xml.PARENTTASKNAME attributes.parenttaskname if attributes.parenttaskname.present?
        xml.BUDGETQTY attributes.budgetqty if attributes.budgetqty.present?
        xml.ESTQTY attributes.estqty if attributes.estqty.present?
        xml.TIMETYPE attributes.timetype if attributes.timetype.present?
        xml.OBSPERCENTCOMPLETE attributes.obspercentcomplete if attributes.obspercentcomplete.present?
        xml.TASKRESOURCES do
          Array.wrap(attributes.employeeid).each do |attributes|
            xml.EMPLOYEEID attributes.employeeid
          end
        end

        if attributes.customfields.present? || attributes.to_h.except(*CREATE_KEYS).present?
          xml.customfields do
            if attributes.customfields.present?
              attributes.customfields.presence&.each do |custom_field|
                xml.customfield do
                  xml.customfieldname custom_field[:customfieldname]
                  xml.customfieldvalue custom_field[:customfieldvalue]
                end
              end
            end

            if attributes.to_h.except(*CREATE_KEYS).present?
              attributes.to_h.except(*CREATE_KEYS).each do |name, value|
                xml.customfield do
                  xml.customfieldname name
                  xml.customfieldvalue value
                end
              end
            end
          end
        end

        xml.CLASSID attributes.classid if attributes.classid.present?
        xml.SUPDOCID attributes.supdocid if attributes.supdocid.present?
        xml.DEPENDENTONKEY attributes.dependentonkey if attributes.dependentonkey.present?
        xml.DEPENDENTONNAME attributes.dependentonname if attributes.dependentonname.present?
      end

      def update_xml(xml)
        xml.TASKNAME attributes.taskname if attributes.taskname.present?
        xml.PROJECTID attributes.projectid if attributes.projectid.present?
        xml.PBEGINDATE format_date(attributes.pbegindate) if attributes.pbegindate.present?
        xml.PENDDATE format_date(attributes.penddate) if attributes.penddate.present?
        xml.ITEMID attributes.itemid if attributes.itemid.present?
        xml.BILLABLE attributes.billable if attributes.billable.present?
        xml.TASKDESCRIPTION attributes.taskdescription if attributes.taskdescription.present?
        xml.ISMILESTONE attributes.ismilestone if attributes.ismilestone.present?
        xml.UTILIZED attributes.utilized if attributes.utilized.present?
        xml.PRIORITY attributes.priority if attributes.priority.present?
        xml.TASKNO attributes.taskno if attributes.taskno.present?
        xml.TASKSTATUS attributes.taskstatus if attributes.taskstatus.present?
        xml.PARENTKEY attributes.parentkey if attributes.parentkey.present?
        xml.PARENTTASKNAME attributes.parenttaskname if attributes.parenttaskname.present?
        xml.BUDGETQTY attributes.budgetqty if attributes.budgetqty.present?
        xml.ESTQTY attributes.estqty if attributes.estqty.present?
        xml.TIMETYPE attributes.timetype if attributes.timetype.present?
        xml.OBSPERCENTCOMPLETE attributes.obspercentcomplete if attributes.obspercentcomplete.present?
        xml.TASKRESOURCES do
          Array.wrap(attributes.employeeid).each do |attributes|
            xml.EMPLOYEEID attributes.employeeid
          end
        end

        if attributes.customfields.present? || attributes.to_h.except(*UPDATE_KEYS).present?
          xml.customfields do
            if attributes.customfields.present?
              attributes.customfields.presence&.each do |custom_field|
                xml.customfield do
                  xml.customfieldname custom_field[:customfieldname]
                  xml.customfieldvalue custom_field[:customfieldvalue]
                end
              end
            end

            if attributes.to_h.except(*UPDATE_KEYS).present?
              attributes.to_h.except(*UPDATE_KEYS).each do |name, value|
                xml.customfield do
                  xml.customfieldname name
                  xml.customfieldvalue value
                end
              end
            end
          end
        end

        xml.CLASSID attributes.classid if attributes.classid.present?
        xml.DEPENDENTONKEY attributes.dependentonkey if attributes.dependentonkey.present?
        xml.DEPENDENTONNAME attributes.dependentonname if attributes.dependentonname.present?
      end
    end
  end
end
