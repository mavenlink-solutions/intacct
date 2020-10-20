module Intacct
  module Models
    class Bill < Intacct::Base
      attr_accessor :customer_data

      api_name "APBILL"

      def create_xml(xml)
        xml.WHENCREATED     attributes.whencreated
        xml.VENDORID        attributes.vendorid
        xml.RECORDID        attributes.recordid
        xml.DESCRIPTION     attributes.description
        xml.WHENDUE         attributes.whendue
        xml.CURRENCY        attributes.currency
        xml.BASECURR        attributes.basecurr
        xml.ACTION          attributes.action
        xml.APBILLITEMS do
          attributes.apbillitems&.each do |bill_item|
            xml.APBILLITEM do
              xml.ACCOUNTNO bill_item[:accountno]
              xml.TRX_AMOUNT bill_item[:trx_amount]
              xml.LOCATIONID bill_item[:locationid]
              xml.DEPARTMENTID bill_item[:departmentid]
              xml.BILLABLE bill_item[:billable]
              xml.PROJECTID bill_item[:projectid]
              xml.TASKID bill_item[:taskid]
              xml.CUSTOMERID bill_item[:customerid]
              xml.EMPLOYEEID bill_item[:employeeid]
              if bill_item[:customfields]
                xml.CUSTOMFIELDS do
                  bill_item[:customfields].each do |customfield|
                    xml.CUSTOMFIELD do
                      xml.CUSTOMFIELDNAME customfield[:customfieldname]
                      xml.CUSTOMFIELDVALUE customfield[:customfieldvalue]
                    end
                  end
                end
              end
            end
          end
        end
        if attributes.customfields
          xml.CUSTOMFIELDS do
            attributes.customfields.each do |customfield|
              xml.CUSTOMFIELD do
                xml.CUSTOMFIELDNAME customfield[:customfieldname]
                xml.CUSTOMFIELDVALUE customfield[:customfieldvalue]
              end
            end
          end
        end
      end

      def update_xml(xml)
        xml.RECORDNO        attributes.recordno
        xml.WHENCREATED     attributes.whencreated
        xml.VENDORID        attributes.vendorid
        xml.RECORDID        attributes.recordid
        xml.DESCRIPTION     attributes.description
        xml.WHENDUE         attributes.whendue
        xml.CURRENCY        attributes.currency
        xml.BASECURR        attributes.basecurr
        xml.ACTION          attributes.action
        xml.APBILLITEMS do
          attributes.apbillitems&.each do |bill_item|
            xml.APBILLITEM do
              xml.LINE_NO bill_item[:line_no]
              xml.ACCOUNTNO bill_item[:accountno]
              xml.TRX_AMOUNT bill_item[:trx_amount]
              xml.LOCATIONID bill_item[:locationid]
              xml.DEPARTMENTID bill_item[:departmentid]
              xml.BILLABLE bill_item[:billable]
              xml.PROJECTID bill_item[:projectid]
              xml.TASKID bill_item[:taskid]
              xml.CUSTOMERID bill_item[:customerid]
              xml.EMPLOYEEID bill_item[:employeeid]
              if bill_item[:customfields]
                xml.CUSTOMFIELDS do
                  bill_item[:customfields].each do |customfield|
                    xml.CUSTOMFIELD do
                      xml.CUSTOMFIELDNAME customfield[:customfieldname]
                      xml.CUSTOMFIELDVALUE customfield[:customfieldvalue]
                    end
                  end
                end
              end
            end
          end
        end
        if attributes.customfields
          xml.CUSTOMFIELDS do
            attributes.customfields.each do |customfield|
              xml.CUSTOMFIELD do
                xml.CUSTOMFIELDNAME customfield[:customfieldname]
                xml.CUSTOMFIELDVALUE customfield[:customfieldvalue]
              end
            end
          end
        end
      end

      def delete
        return false unless attributes.payment.intacct_system_id.present?

        send_xml("delete") do |xml|
          xml.function(controlid: "1") do
            xml.delete_bill(externalkey: "false", key: attributes.payment.intacct_key)
          end
        end

        successful?
      end
    end
  end
end
