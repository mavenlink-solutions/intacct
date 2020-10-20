module Intacct
  module Models
    class Expense < Intacct::Base
      api_name "EEXPENSES"

      def create_name
        "create_expensereport"
      end

      def create_xml(xml)
        xml.employeeid attributes.employeeid
        xml.datecreated do
          xml.year  attributes.datecreated.try(:strftime, "%Y")
          xml.month attributes.datecreated.try(:strftime, "%m")
          xml.day   attributes.datecreated.try(:strftime, "%d")
        end
        xml.expensereportno attributes.expensereportno
        xml.description     attributes.description
        xml.memo            attributes.memo
        xml.basecurr        attributes.basecurr
        xml.currency        attributes.currency
        xml.dateposted do
          xml.year  attributes.dateposted.try(:strftime, "%Y")
          xml.month attributes.dateposted.try(:strftime, "%m")
          xml.day   attributes.dateposted.try(:strftime, "%d")
        end
        xml.state attributes.state

        xml.expenses do
          attributes.expenses.each do |expense|
            xml.expense do
              xml.expensetype  expense[:expensetype]
              xml.amount       expense[:amount]
              xml.expensedate  do
                xml.year  expense[:expensedate].try(:strftime, "%Y")
                xml.month expense[:expensedate].try(:strftime, "%m")
                xml.day   expense[:expensedate].try(:strftime, "%d")
              end
              xml.memo         expense[:memo]
              xml.paidfor      expense[:paidfor]
              xml.locationid   expense[:locationid]
              xml.departmentid expense[:departmentid]
              xml.projectid    expense[:projectid]
              xml.taskid       expense[:taskid]
              xml.itemid       expense[:itemid]
              xml.billable     expense[:billable]
            end
          end
        end
      end

      def update_xml(xml)
        xml.recordno recordno
        xml.employeeid attributes.employeeid
        xml.datecreated do
          xml.year  attributes.datecreated.try(:strftime, "%Y")
          xml.month attributes.datecreated.try(:strftime, "%m")
          xml.day   attributes.datecreated.try(:strftime, "%d")
        end
        xml.expensereportno attributes.expensereportno
        xml.description     attributes.description
        xml.basecurr        attributes.basecurr
        xml.currency        attributes.currency

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

        if attributes.updateexpenses
          xml.updateexpenses do
            attributes.updateexpenses.each do |updateexpense|
              xml.updateexpense do
                xml.expensetype  updateexpense[:expensetype]
                xml.glaccountno  updateexpense[:glaccountno]
                xml.amount       updateexpense[:amount]
                xml.currency     updateexpense[:currency]
                xml.trx_amount   updateexpense[:trx_amount]
                xml.exchratedate do
                  xml.year  updateexpense[:exchratedate].try(:strftime, "%Y")
                  xml.month updateexpense[:exchratedate].try(:strftime, "%m")
                  xml.day   updateexpense[:exchratedate].try(:strftime, "%d")
                end
                xml.exchratetype  updateexpense[:exchratetype]
                xml.exchrate      updateexpense[:exchrate]
                xml.expensedate do
                  xml.year  updateexpense[:expensedate].try(:strftime, "%Y")
                  xml.month updateexpense[:expensedate].try(:strftime, "%m")
                  xml.day   updateexpense[:expensedate].try(:strftime, "%d")
                end
                xml.memo         updateexpense[:memo]
                xml.locationid   updateexpense[:locationid]
                xml.departmentid updateexpense[:departmentid]
                if updateexpense[:customfields]
                  xml.customfields do
                    updateexpense[:customfields].each do |customfield|
                      xml.customfield do
                        xml.customfieldname customfield[:name]
                        xml.customfieldvalue customfield[:value]
                      end
                    end
                  end
                end
                xml.projectid   updateexpense[:projectid]
                xml.taskid      updateexpense[:taskid]
                xml.customerid  updateexpense[:customerid]
                xml.vendorid    updateexpense[:vendorid]
                xml.employeeid  updateexpense[:employeeid]
                xml.itemid      updateexpense[:itemid]
                xml.classid     updateexpense[:classid]
              end
            end
          end
        end
      end
    end
  end
end
