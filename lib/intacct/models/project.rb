module Intacct
  module Models
    class Project < Intacct::Base
      CREATE_PROJECT_KEYS = %i[projectid
                               name
                               description
                               parentid
                               invoicewithparent
                               projectcategory
                               projecttype
                               projectstatus
                               customerid
                               managerid
                               custuserid
                               salescontactid
                               begindate
                               enddate
                               departmentid
                               locationid
                               classid
                               currency
                               billingtype
                               termname
                               docnumber
                               billto
                               shipto
                               contactinfo
                               sonumber
                               ponumber
                               poamount
                               pqnumber
                               budgetamount
                               budgetedcost
                               budgetqty
                               userrestrictions
                               obspercentcomplete
                               budgetid
                               billingrate
                               billingpricing
                               expenserate
                               expensepricing
                               poaprate
                               poappricing
                               status
                               supdocid
                               invoicemessage
                               invoicecurrency
                               projectresources
                               billingovermax
                               excludeexpenses
                               customfields].freeze

      UPDATE_PROJECT_KEYS = CREATE_PROJECT_KEYS

      def create_xml(xml)
        xml.PROJECTID attributes.projectid
        xml.NAME attributes.name
        xml.DESCRIPTION attributes.description if attributes.description.present?
        xml.PARENTID attributes.parentid if attributes.parentid.present?
        xml.INVOICEWITHPARENT attributes.invoicewithparent if attributes.invoicewithparent.present?
        xml.PROJECTCATEGORY attributes.projectcategory
        xml.PROJECTTYPE attributes.projecttype if attributes.projecttype.present?
        xml.PROJECTSTATUS attributes.projectstatus if attributes.projectstatus.present?
        xml.CUSTOMERID attributes.customerid if attributes.customerid.present?
        xml.MANAGERID attributes.managerid if attributes.managerid.present?
        xml.CUSTUSERID attributes.custuserid if attributes.custuserid.present?
        xml.SALESCONTACTID attributes.salescontactid if attributes.salescontactid.present?
        xml.BEGINDATE attributes.begindate.strftime("%m/%d/%Y") if attributes.begindate.present?
        xml.ENDDATE attributes.enddate.strftime("%m/%d/%Y") if attributes.enddate.present?
        xml.DEPARTMENTID attributes.departmentid if attributes.departmentid.present?
        xml.LOCATIONID attributes.locationid if attributes.locationid.present?
        xml.CLASSID attributes.classid if attributes.classid.present?
        xml.CURRENCY attributes.currency if attributes.currency.present?
        xml.BILLINGTYPE attributes.billingtype if attributes.billingtype.present?
        xml.TERMNAME attributes.termname if attributes.termname.present?
        xml.DOCNUMBER attributes.docnumber if attributes.docnumber.present?
        xml.BILLTO attributes.billto if attributes.billto.present?
        xml.SHIPTO attributes.shipto if attributes.shipto.present?
        xml.CONTACTINFO attributes.contactinfo if attributes.contactinfo.present?
        xml.SONUMBER attributes.sonumber if attributes.sonumber.present?
        xml.PONUMBER attributes.ponumber if attributes.ponumber.present?
        xml.POAMOUNT attributes.poamount if attributes.poamount.present?
        xml.PQNUMBER attributes.pqnumber if attributes.pqnumber.present?
        xml.BUDGETAMOUNT attributes.budgetamount if attributes.budgetamount.present?
        xml.BUDGETEDCOST attributes.budgetedcost if attributes.budgetedcost.present?
        xml.BUDGETQTY attributes.budgetqty if attributes.budgetqty.present?
        xml.USERRESTRICTIONS attributes.userrestrictions if attributes.userrestrictions.present?
        xml.OBSPERCENTCOMPLETE attributes.obspercentcomplete if attributes.obspercentcomplete.present?
        xml.BUDGETID attributes.budgetid if attributes.budgetid.present?
        xml.BILLINGRATE attributes.billingrate if attributes.billingrate.present?
        xml.BILLINGPRICING attributes.billingpricing if attributes.billingpricing.present?
        xml.EXPENSERATE attributes.expenserate if attributes.expenserate.present?
        xml.EXPENSEPRICING attributes.expensepricing if attributes.expensepricing.present?
        xml.POAPRATE attributes.poaprate if attributes.poaprate.present?
        xml.POAPPRICING attributes.poappricing if attributes.poappricing.present?
        xml.STATUS attributes.status if attributes.status.present?
        xml.SUPDOCID attributes.supdocid if attributes.supdocid.present?
        xml.INVOICEMESSAGE attributes.invoicemessage if attributes.invoicemessage.present?
        xml.INVOICECURRENCY attributes.invoicecurrency if attributes.invoicecurrency.present?
        if attributes.projectresources.present?
          Array.wrap(attributes.projectresources).each do |attributes|
            xml.PROJECTRESOURCES do
              if attributes.projectresource.present?
                Array.wrap(attributes.projectresources).each do |attributes|
                  xml.PROJECTRESOURCE do
                    xml.EMPLOYEEID attributes.employeeid
                    xml.ITEMID attributes.itemid if attributes.itemid.present?
                    xml.RESOURCEDESCRIPTION attributes.resourcedescription if attributes.resourcedescription.present?
                    xml.STARTDATE attributes.startdate.strftime("%m/%d/%Y") if attributes.startdate.present?
                    xml.BILLINGRATE attributes.billingrate if attributes.billingrate.present?
                    xml.EXPENSERATE attributes.expenserate if attributes.expenserate.present?
                    xml.POAPRATE attributes.poaprate if attributes.poaprate.present?
                  end
                end

              end
            end
          end

        end

        xml.BILLINGOVERMAX attributes.billingovermax if attributes.billingovermax.present?
        xml.EXCLUDEEXPENSES attributes.excludeexpenses if attributes.excludeexpenses.present?
        if attributes.customfields.present? || attributes.to_h.except(*CREATE_PROJECT_KEYS).present?
          xml.customfields do
            if attributes.customfields.present?
              attributes.customfields.presence&.each do |custom_field|
                xml.customfield do
                  xml.customfieldname custom_field[:customfieldname]
                  xml.customfieldvalue custom_field[:customfieldvalue]
                end
              end
            end

            if attributes.to_h.except(*CREATE_PROJECT_KEYS).present?
              attributes.to_h.except(*CREATE_PROJECT_KEYS).each do |name, value|
                xml.customfield do
                  xml.customfieldname name
                  xml.customfieldvalue value
                end
              end
            end
          end
        end
      end

      def update_xml(xml)
        xml.PROJECTID attributes.projectid
        xml.NAME attributes.name
        xml.DESCRIPTION attributes.description if attributes.description.present?
        xml.PARENTID attributes.parentid if attributes.parentid.present?
        xml.INVOICEWITHPARENT attributes.invoicewithparent if attributes.invoicewithparent.present?
        xml.PROJECTCATEGORY attributes.projectcategory
        xml.PROJECTTYPE attributes.projecttype if attributes.projecttype.present?
        xml.PROJECTSTATUS attributes.projectstatus if attributes.projectstatus.present?
        xml.CUSTOMERID attributes.customerid if attributes.customerid.present?
        xml.MANAGERID attributes.managerid if attributes.managerid.present?
        xml.CUSTUSERID attributes.custuserid if attributes.custuserid.present?
        xml.SALESCONTACTID attributes.salescontactid if attributes.salescontactid.present?
        xml.BEGINDATE attributes.begindate.strftime("%m/%d/%Y") if attributes.begindate.present?
        xml.ENDDATE attributes.enddate.strftime("%m/%d/%Y") if attributes.enddate.present?
        xml.DEPARTMENTID attributes.departmentid if attributes.departmentid.present?
        xml.LOCATIONID attributes.locationid if attributes.locationid.present?
        xml.CLASSID attributes.classid if attributes.classid.present?
        xml.CURRENCY attributes.currency if attributes.currency.present?
        xml.BILLINGTYPE attributes.billingtype if attributes.billingtype.present?
        xml.TERMNAME attributes.termname if attributes.termname.present?
        xml.DOCNUMBER attributes.docnumber if attributes.docnumber.present?
        xml.BILLTO attributes.billto if attributes.billto.present?
        xml.SHIPTO attributes.shipto if attributes.shipto.present?
        xml.CONTACTINFO attributes.contactinfo if attributes.contactinfo.present?
        xml.SONUMBER attributes.sonumber if attributes.sonumber.present?
        xml.PONUMBER attributes.ponumber if attributes.ponumber.present?
        xml.POAMOUNT attributes.poamount if attributes.poamount.present?
        xml.PQNUMBER attributes.pqnumber if attributes.pqnumber.present?
        xml.BUDGETAMOUNT attributes.budgetamount if attributes.budgetamount.present?
        xml.BUDGETEDCOST attributes.budgetedcost if attributes.budgetedcost.present?
        xml.BUDGETQTY attributes.budgetqty if attributes.budgetqty.present?
        xml.USERRESTRICTIONS attributes.userrestrictions if attributes.userrestrictions.present?
        xml.OBSPERCENTCOMPLETE attributes.obspercentcomplete if attributes.obspercentcomplete.present?
        xml.BUDGETID attributes.budgetid if attributes.budgetid.present?
        xml.BILLINGRATE attributes.billingrate if attributes.billingrate.present?
        xml.BILLINGPRICING attributes.billingpricing if attributes.billingpricing.present?
        xml.EXPENSERATE attributes.expenserate if attributes.expenserate.present?
        xml.EXPENSEPRICING attributes.expensepricing if attributes.expensepricing.present?
        xml.POAPRATE attributes.poaprate if attributes.poaprate.present?
        xml.POAPPRICING attributes.poappricing if attributes.poappricing.present?
        xml.STATUS attributes.status if attributes.status.present?
        xml.SUPDOCID attributes.supdocid if attributes.supdocid.present?
        xml.INVOICEMESSAGE attributes.invoicemessage if attributes.invoicemessage.present?
        xml.INVOICECURRENCY attributes.invoicecurrency if attributes.invoicecurrency.present?
        if attributes.projectresources.present?
          Array.wrap(attributes.projectresources).each do |attributes|
            xml.PROJECTRESOURCES do
              if attributes.projectresource.present?
                Array.wrap(attributes.projectresources).each do |attributes|
                  xml.PROJECTRESOURCE do
                    xml.EMPLOYEEID attributes.employeeid
                    xml.ITEMID attributes.itemid if attributes.itemid.present?
                    xml.RESOURCEDESCRIPTION attributes.resourcedescription if attributes.resourcedescription.present?
                    xml.STARTDATE attributes.startdate.strftime("%m/%d/%Y") if attributes.startdate.present?
                    xml.BILLINGRATE attributes.billingrate if attributes.billingrate.present?
                    xml.EXPENSERATE attributes.expenserate if attributes.expenserate.present?
                    xml.POAPRATE attributes.poaprate if attributes.poaprate.present?
                  end
                end

              end
            end
          end

        end

        xml.BILLINGOVERMAX attributes.billingovermax if attributes.billingovermax.present?
        xml.EXCLUDEEXPENSES attributes.excludeexpenses if attributes.excludeexpenses.present?
        if attributes.customfields.present? || attributes.to_h.except(*UPDATE_PROJECT_KEYS).present?
          xml.customfields do
            if attributes.customfields.present?
              attributes.customfields.presence&.each do |custom_field|
                xml.customfield do
                  xml.customfieldname custom_field[:customfieldname]
                  xml.customfieldvalue custom_field[:customfieldvalue]
                end
              end
            end

            if attributes.to_h.except(*UPDATE_PROJECT_KEYS).present?
              attributes.to_h.except(*UPDATE_PROJECT_KEYS).each do |name, value|
                xml.customfield do
                  xml.customfieldname name
                  xml.customfieldvalue value
                end
              end
            end
          end
        end
      end
    end
  end
end
