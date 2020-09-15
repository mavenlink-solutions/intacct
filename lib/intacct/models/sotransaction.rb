module Intacct
  module Models
    class Sotransaction < Intacct::Base
      CREATE_SOTRANSACTION_KEYS = %i[transactiontype
                                     datecreated
                                     dateposted
                                     createdfrom
                                     customerid
                                     documentno
                                     origdocdate
                                     referenceno
                                     termname
                                     datedue
                                     message
                                     shippingmethod
                                     shipto
                                     billto
                                     supdocid
                                     externalid
                                     basecurr
                                     currency
                                     exchratedate
                                     exchratetype
                                     exchrate
                                     vsoepricelist
                                     customfields
                                     state
                                     projectid
                                     sotransitems
                                     subtotals].freeze

      UPDATE_SOTRANSACTION_KEYS = %i[datecreated
                                     dateposted
                                     referenceno
                                     termname
                                     datedue
                                     origdocdate
                                     message
                                     shippingmethod
                                     shipto
                                     billto
                                     supdocid
                                     externalid
                                     basecurr
                                     currency
                                     exchratedate
                                     exchratetype
                                     exchrate
                                     vsoepricelist
                                     customfields
                                     state
                                     projectid
                                     updatesotransitems
                                     updatesubtotals].freeze

      SOTRANSITEM_KEYS = %i[bundlenumber
                            itemid
                            itemdesc
                            taxable
                            warehouseid
                            quantity
                            unit
                            linelevelsimpletaxtype
                            discountpercent
                            price
                            sourcelinekey
                            discsurchargememo
                            locationid
                            departmentid
                            memo
                            itemdetails
                            customfields
                            revrectemplate
                            revrecstartdate
                            revrecenddate
                            renewalmacro
                            projectid
                            customerid
                            vendorid
                            employeeid
                            classid
                            contractid
                            fulfillmentstatus
                            taskno
                            billingtemplate
                            dropship
                            shipto].freeze

      SUBTOTAL_KEYS = %i[description total absval percentval locationid departmentid projectid customerid vendorid employeeid classid itemid contractid customfields].freeze

      UPDATESUBTOTAL_KEYS = %i[description
                               total
                               absval
                               percentval
                               locationid
                               departmentid
                               projectid
                               customerid
                               vendorid
                               employeeid
                               classid
                               itemid
                               contractid
                               customfields].freeze

      def create_xml(xml)
        xml.transactiontype attributes.transactiontype
        xml.datecreated do
          xml.year attributes.datecreated.year
          xml.month attributes.datecreated.month
          xml.day attributes.datecreated.day
        end

        if attributes.dateposted.present?
          xml.dateposted do
            xml.year attributes.dateposted.year
            xml.month attributes.dateposted.month
            xml.day attributes.dateposted.day
          end

        end

        xml.createdfrom attributes.createdfrom if attributes.createdfrom.present?
        xml.customerid attributes.customerid
        xml.documentno attributes.documentno if attributes.documentno.present?
        if attributes.origdocdate.present?
          xml.origdocdate do
            xml.year attributes.origdocdate.year
            xml.month attributes.origdocdate.month
            xml.day attributes.origdocdate.day
          end

        end

        xml.referenceno attributes.referenceno if attributes.referenceno.present?
        xml.termname attributes.termname if attributes.termname.present?
        if attributes.datedue.present?
          xml.datedue do
            xml.year attributes.datedue.year
            xml.month attributes.datedue.month
            xml.day attributes.datedue.day
          end

        end

        xml.message attributes.message if attributes.message.present?
        xml.shippingmethod attributes.shippingmethod if attributes.shippingmethod.present?
        xml.shipto attributes.shipto if attributes.shipto.present?
        xml.billto attributes.billto if attributes.billto.present?
        xml.supdocid attributes.supdocid if attributes.supdocid.present?
        xml.externalid attributes.externalid if attributes.externalid.present?
        xml.basecurr attributes.basecurr if attributes.basecurr.present?
        xml.currency attributes.currency
        if attributes.exchratedate.present?
          xml.exchratedate do
            xml.year attributes.exchratedate.year
            xml.month attributes.exchratedate.month
            xml.day attributes.exchratedate.day
          end

        end

        xml.exchratetype attributes.exchratetype if attributes.exchratetype.present?
        xml.exchrate attributes.exchrate if attributes.exchrate.present?
        xml.vsoepricelist attributes.vsoepricelist if attributes.vsoepricelist.present?
        if attributes.customfields.present? || attributes.to_h.except(*CREATE_SOTRANSACTION_KEYS).present?
          xml.customfields do
            if attributes.customfields.present?
              attributes.customfields.presence&.each do |custom_field|
                xml.customfield do
                  xml.customfieldname custom_field[:customfieldname]
                  xml.customfieldvalue custom_field[:customfieldvalue]
                end
              end
            end

            if attributes.to_h.except(*CREATE_SOTRANSACTION_KEYS).present?
              attributes.to_h.except(*CREATE_SOTRANSACTION_KEYS).each do |name, value|
                xml.customfield do
                  xml.customfieldname name
                  xml.customfieldvalue value
                end
              end
            end
          end
        end

        xml.state attributes.state if attributes.state.present?
        xml.projectid attributes.projectid if attributes.projectid.present?
        if attributes.sotransitems.present?
          xml.sotransitems do
            Array.wrap(attributes.sotransitems).each do |attributes|
              xml.sotransitem do
                xml.bundlenumber attributes.bundlenumber if attributes.bundlenumber.present?
                xml.itemid attributes.itemid
                xml.itemdesc attributes.itemdesc if attributes.itemdesc.present?
                xml.taxable attributes.taxable if attributes.taxable.present?
                xml.warehouseid attributes.warehouseid if attributes.warehouseid.present?
                xml.quantity attributes.quantity
                xml.unit attributes.unit if attributes.unit.present?
                xml.linelevelsimpletaxtype attributes.linelevelsimpletaxtype if attributes.linelevelsimpletaxtype.present?
                xml.discountpercent attributes.discountpercent if attributes.discountpercent.present?
                xml.price attributes.price if attributes.price.present?
                xml.sourcelinekey attributes.sourcelinekey if attributes.sourcelinekey.present?
                xml.discsurchargememo attributes.discsurchargememo if attributes.discsurchargememo.present?
                xml.locationid attributes.locationid if attributes.locationid.present?
                xml.departmentid attributes.departmentid if attributes.departmentid.present?
                xml.memo attributes.memo if attributes.memo.present?
                if attributes.itemdetails.present?
                  xml.itemdetails do
                    Array.wrap(attributes.itemdetails).each do |attributes|
                      xml.itemdetail do
                        xml.componentid attributes.componentid if attributes.componentid.present?
                        xml.quantity attributes.quantity if attributes.quantity.present?
                        xml.serialno attributes.serialno
                        xml.lotno attributes.lotno
                        xml.aisle attributes.aisle if attributes.aisle.present?
                        xml.row attributes.row if attributes.row.present?
                        xml.bin attributes.bin if attributes.bin.present?
                        if attributes.itemexpiration.present?
                          xml.itemexpiration do
                            xml.year attributes.itemexpiration.year
                            xml.month attributes.itemexpiration.month
                            xml.day attributes.itemexpiration.day
                          end

                        end
                      end
                    end
                  end

                end

                if attributes.customfields.present? || attributes.to_h.except(*SOTRANSITEM_KEYS).present?
                  xml.customfields do
                    if attributes.customfields.present?
                      attributes.customfields.presence&.each do |custom_field|
                        xml.customfield do
                          xml.customfieldname custom_field[:customfieldname]
                          xml.customfieldvalue custom_field[:customfieldvalue]
                        end
                      end
                    end

                    if attributes.to_h.except(*SOTRANSITEM_KEYS).present?
                      attributes.to_h.except(*SOTRANSITEM_KEYS).each do |name, value|
                        xml.customfield do
                          xml.customfieldname name
                          xml.customfieldvalue value
                        end
                      end
                    end
                  end
                end

                xml.revrectemplate attributes.revrectemplate if attributes.revrectemplate.present?
                if attributes.revrecstartdate.present?
                  xml.revrecstartdate do
                    xml.year attributes.revrecstartdate.year
                    xml.month attributes.revrecstartdate.month
                    xml.day attributes.revrecstartdate.day
                  end

                end

                if attributes.revrecenddate.present?
                  xml.revrecenddate do
                    xml.year attributes.revrecenddate.year
                    xml.month attributes.revrecenddate.month
                    xml.day attributes.revrecenddate.day
                  end

                end

                xml.renewalmacro attributes.renewalmacro if attributes.renewalmacro.present?
                xml.projectid attributes.projectid if attributes.projectid.present?
                xml.customerid attributes.customerid if attributes.customerid.present?
                xml.vendorid attributes.vendorid if attributes.vendorid.present?
                xml.employeeid attributes.employeeid if attributes.employeeid.present?
                xml.classid attributes.classid if attributes.classid.present?
                xml.contractid attributes.contractid if attributes.contractid.present?
                xml.fulfillmentstatus attributes.fulfillmentstatus if attributes.fulfillmentstatus.present?
                xml.taskno attributes.taskno if attributes.taskno.present?
                xml.billingtemplate attributes.billingtemplate if attributes.billingtemplate.present?
                xml.dropship attributes.dropship if attributes.dropship.present?
                xml.shipto attributes.shipto if attributes.shipto.present?
              end
            end
          end

        end

        if attributes.subtotals.present?
          xml.subtotals do
            Array.wrap(attributes.subtotals).each do |attributes|
              xml.subtotal do
                xml.description attributes.description
                xml.total attributes.total
                xml.absval attributes.absval if attributes.absval.present?
                xml.percentval attributes.percentval if attributes.percentval.present?
                xml.locationid attributes.locationid if attributes.locationid.present?
                xml.departmentid attributes.departmentid if attributes.departmentid.present?
                xml.projectid attributes.projectid if attributes.projectid.present?
                xml.customerid attributes.customerid if attributes.customerid.present?
                xml.vendorid attributes.vendorid if attributes.vendorid.present?
                xml.employeeid attributes.employeeid if attributes.employeeid.present?
                xml.classid attributes.classid if attributes.classid.present?
                xml.itemid attributes.itemid if attributes.itemid.present?
                xml.contractid attributes.contractid if attributes.contractid.present?
                if attributes.customfields.present? || attributes.to_h.except(*SUBTOTAL_KEYS).present?
                  xml.customfields do
                    if attributes.customfields.present?
                      attributes.customfields.presence&.each do |custom_field|
                        xml.customfield do
                          xml.customfieldname custom_field[:customfieldname]
                          xml.customfieldvalue custom_field[:customfieldvalue]
                        end
                      end
                    end

                    if attributes.to_h.except(*SUBTOTAL_KEYS).present?
                      attributes.to_h.except(*SUBTOTAL_KEYS).each do |name, value|
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
      end

      def update_xml(xml)
        if attributes.datecreated.present?
          xml.datecreated do
            xml.year attributes.datecreated.year
            xml.month attributes.datecreated.month
            xml.day attributes.datecreated.day
          end

        end

        if attributes.dateposted.present?
          xml.dateposted do
            xml.year attributes.dateposted.year
            xml.month attributes.dateposted.month
            xml.day attributes.dateposted.day
          end

        end

        xml.referenceno attributes.referenceno if attributes.referenceno.present?
        xml.termname attributes.termname if attributes.termname.present?
        if attributes.datedue.present?
          xml.datedue do
            xml.year attributes.datedue.year
            xml.month attributes.datedue.month
            xml.day attributes.datedue.day
          end

        end

        if attributes.origdocdate.present?
          xml.origdocdate do
            xml.year attributes.origdocdate.year
            xml.month attributes.origdocdate.month
            xml.day attributes.origdocdate.day
          end

        end

        xml.message attributes.message if attributes.message.present?
        xml.shippingmethod attributes.shippingmethod if attributes.shippingmethod.present?
        xml.shipto attributes.shipto if attributes.shipto.present?
        xml.billto attributes.billto if attributes.billto.present?
        xml.supdocid attributes.supdocid if attributes.supdocid.present?
        xml.externalid attributes.externalid if attributes.externalid.present?
        xml.basecurr attributes.basecurr if attributes.basecurr.present?
        xml.currency attributes.currency
        if attributes.exchratedate.present?
          xml.exchratedate do
            xml.year attributes.exchratedate.year
            xml.month attributes.exchratedate.month
            xml.day attributes.exchratedate.day
          end

        end

        xml.exchratetype attributes.exchratetype if attributes.exchratetype.present?
        xml.exchrate attributes.exchrate if attributes.exchrate.present?
        xml.vsoepricelist attributes.vsoepricelist if attributes.vsoepricelist.present?
        if attributes.customfields.present? || attributes.to_h.except(*UPDATE_SOTRANSACTION_KEYS).present?
          xml.customfields do
            if attributes.customfields.present?
              attributes.customfields.presence&.each do |custom_field|
                xml.customfield do
                  xml.customfieldname custom_field[:customfieldname]
                  xml.customfieldvalue custom_field[:customfieldvalue]
                end
              end
            end

            if attributes.to_h.except(*UPDATE_SOTRANSACTION_KEYS).present?
              attributes.to_h.except(*UPDATE_SOTRANSACTION_KEYS).each do |name, value|
                xml.customfield do
                  xml.customfieldname name
                  xml.customfieldvalue value
                end
              end
            end
          end
        end

        xml.state attributes.state if attributes.state.present?
        xml.projectid attributes.projectid if attributes.projectid.present?
        xml.updatesotransitems attributes.updatesotransitems if attributes.updatesotransitems.present?
        if attributes.updatesubtotals.present?
          xml.updatesubtotals do
            Array.wrap(attributes.updatesubtotals).each do |attributes|
              xml.updatesubtotal do
                xml.description attributes.description
                xml.total attributes.total
                xml.absval attributes.absval if attributes.absval.present?
                xml.percentval attributes.percentval if attributes.percentval.present?
                xml.locationid attributes.locationid if attributes.locationid.present?
                xml.departmentid attributes.departmentid if attributes.departmentid.present?
                xml.projectid attributes.projectid if attributes.projectid.present?
                xml.customerid attributes.customerid if attributes.customerid.present?
                xml.vendorid attributes.vendorid if attributes.vendorid.present?
                xml.employeeid attributes.employeeid if attributes.employeeid.present?
                xml.classid attributes.classid if attributes.classid.present?
                xml.itemid attributes.itemid if attributes.itemid.present?
                xml.contractid attributes.contractid if attributes.contractid.present?
                if attributes.customfields.present? || attributes.to_h.except(*UPDATESUBTOTAL_KEYS).present?
                  xml.customfields do
                    if attributes.customfields.present?
                      attributes.customfields.presence&.each do |custom_field|
                        xml.customfield do
                          xml.customfieldname custom_field[:customfieldname]
                          xml.customfieldvalue custom_field[:customfieldvalue]
                        end
                      end
                    end

                    if attributes.to_h.except(*UPDATESUBTOTAL_KEYS).present?
                      attributes.to_h.except(*UPDATESUBTOTAL_KEYS).each do |name, value|
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
      end
    end
  end
end
