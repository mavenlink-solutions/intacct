module Intacct
  module Models
    class Expense < Intacct::Base

      api_name 'EEXPENSES'

      def create_name
        'create_expensereport'
      end

      def create_xml(xml)
        xml.employeeid attributes.employeeid
        xml.datecreated  {
          xml.year  attributes.datecreated.try(:strftime, "%Y")
          xml.month attributes.datecreated.try(:strftime, "%m")
          xml.day   attributes.datecreated.try(:strftime, "%d")
        }
        xml.expensereportno attributes.expensereportno
        xml.description     attributes.description
        xml.memo            attributes.memo
        xml.basecurr        attributes.basecurr
        xml.currency        attributes.currency
        xml.dateposted  {
          xml.year  attributes.dateposted.try(:strftime, "%Y")
          xml.month attributes.dateposted.try(:strftime, "%m")
          xml.day   attributes.dateposted.try(:strftime, "%d")
        }
        xml.state           attributes.state

        if attributes.customfields
          xml.customfields {
            attributes.customfields.each { |customfield|
              xml.customfield {
                xml.customfieldname customfield[:customfieldname]
                xml.customfieldvalue customfield[:customfieldvalue]
              }
            }
          }
        end

        xml.expenses {
          attributes.expenses.each { |expense|
            xml.expense {
              xml.expensetype  expense[:expensetype]
              xml.amount       expense[:amount]
              xml.expensedate  {
                xml.year  expense[:expensedate].try(:strftime, "%Y")
                xml.month expense[:expensedate].try(:strftime, "%m")
                xml.day   expense[:expensedate].try(:strftime, "%d")
              }
              xml.memo         expense[:memo]
              xml.paidfor      expense[:paidfor]
              xml.locationid   expense[:locationid]
              xml.departmentid expense[:departmentid]
              xml.projectid    expense[:projectid]
              xml.itemid       expense[:itemid]
              xml.billable     expense[:billable]
            }
          }
        }
      end

      def update_xml(xml)
        xml.employeeid attributes.employeeid if attributes.employeeid.present?
        if attributes.datecreated.present?
          xml.datecreated  {
            xml.year  attributes.datecreated.try(:strftime, "%Y")
            xml.month attributes.datecreated.try(:strftime, "%m")
            xml.day   attributes.datecreated.try(:strftime, "%d")
          }
        end
        xml.state           attributes.state if attributes.state.present?
        xml.expensereportno attributes.expensereportno if attributes.expensereportno.present?
        xml.description     attributes.description if attributes.description.present?
        xml.basecurr        attributes.basecurr if attributes.basecurr.present?
        xml.currency        attributes.currency if attributes.currency.present?

        if attributes.customfields
          xml.customfields {
            attributes.customfields.each do |customfield|
              xml.customfield {
                xml.customfieldname customfield[:customfieldname]
                xml.customfieldvalue customfield[:customfieldvalue]
              }
            end
          }
        end

        if attributes.updateexpenses
          xml.updateexpenses {
            attributes.updateexpenses.each { |updateexpense|
              xml.updateexpense(line_num: updateexpense[:line_num]) {
                if updateexpense[:expensetype].present?
                  xml.expensetype updateexpense[:expensetype]
                elsif updateexpense[:glaccountno].present?
                  xml.glaccountno updateexpense[:glaccounton]
                end

                xml.amount       updateexpense[:amount] if updateexpense[:amount].present?
                xml.currency     updateexpense[:currency] if updateexpense[:currency].present?
                xml.trx_amount   updateexpense[:trx_amount] if updateexpense[:trx_amount].present?

                if updateexpense[:exchratedate].present?
                  xml.exchratedate  {
                    xml.year  updateexpense[:exchratedate].try(:strftime, "%Y")
                    xml.month updateexpense[:exchratedate].try(:strftime, "%m")
                    xml.day   updateexpense[:exchratedate].try(:strftime, "%d")
                  }
                end

                xml.exchratetype  updateexpense[:exchratetype] if updateexpense[:exchratetype].present?
                xml.exchrate      updateexpense[:exchrate] if updateexpense[:exchrate].present?

                if updateexpense[:expensedate].present?
                  xml.expensedate  {
                    xml.year  updateexpense[:expensedate].try(:strftime, "%Y")
                    xml.month updateexpense[:expensedate].try(:strftime, "%m")
                    xml.day   updateexpense[:expensedate].try(:strftime, "%d")
                  }
                end

                xml.memo         updateexpense[:memo] if updateexpense[:memo].present?
                xml.locationid   updateexpense[:locationid] if updateexpense[:locationid].present?
                xml.departmentid updateexpense[:departmentid] if updateexpense[:departmentid].present?

                if updateexpense[:customfields]
                  xml.customfields {
                    updateexpense[:customfields].each do |customfield|
                      xml.customfield {
                        xml.customfieldname customfield[:name]
                        xml.customfieldvalue customfield[:value]
                      }
                    end
                  }
                end

                xml.projectid   updateexpense[:projectid] if updateexpense[:projectid].present?
                xml.customerid  updateexpense[:customerid] if updateexpense[:customerid].present?
                xml.vendorid    updateexpense[:vendorid] if updateexpense[:vendorid].present?
                xml.employeeid  updateexpense[:employeeid] if updateexpense[:employeeid].present?
                xml.itemid      updateexpense[:itemid] if updateexpense[:itemid].present?
                xml.classid     updateexpense[:classid] if updateexpense[:classid].present?
              }
            }
          }
        end

      end
    end
  end
end
