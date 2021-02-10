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

      api_name "SODOCUMENT"
      id_attribute "docid"

      def create_xml(xml)
        xml.transactiontype attributes.transactiontype
        xml.datecreated do
          xml.year parse_date(attributes.datecreated).year
          xml.month parse_date(attributes.datecreated).month
          xml.day parse_date(attributes.datecreated).day
        end

        if attributes.dateposted.present?
          xml.dateposted do
            xml.year parse_date(attributes.dateposted).year
            xml.month parse_date(attributes.dateposted).month
            xml.day parse_date(attributes.dateposted).day
          end

        end

        xml.createdfrom attributes.createdfrom if attributes.createdfrom.present?
        xml.customerid attributes.customerid
        xml.documentno attributes.documentno if attributes.documentno.present?
        if attributes.origdocdate.present?
          xml.origdocdate do
            xml.year parse_date(attributes.origdocdate).year
            xml.month parse_date(attributes.origdocdate).month
            xml.day parse_date(attributes.origdocdate).day
          end

        end

        xml.referenceno attributes.referenceno if attributes.referenceno.present?
        xml.termname attributes.termname if attributes.termname.present?
        if attributes.datedue.present?
          xml.datedue do
            xml.year parse_date(attributes.datedue).year
            xml.month parse_date(attributes.datedue).month
            xml.day parse_date(attributes.datedue).day
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
            xml.year parse_date(attributes.exchratedate).year
            xml.month parse_date(attributes.exchratedate).month
            xml.day parse_date(attributes.exchratedate).day
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
                            xml.year parse_date(attributes.itemexpiration).year
                            xml.month parse_date(attributes.itemexpiration).month
                            xml.day parse_date(attributes.itemexpiration).day
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
                    xml.year parse_date(attributes.revrecstartdate).year
                    xml.month parse_date(attributes.revrecstartdate).month
                    xml.day parse_date(attributes.revrecstartdate).day
                  end

                end

                if attributes.revrecenddate.present?
                  xml.revrecenddate do
                    xml.year parse_date(attributes.revrecenddate).year
                    xml.month parse_date(attributes.revrecenddate).month
                    xml.day parse_date(attributes.revrecenddate).day
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

      def update_xml(xml, attributes_override = {})
        update_attributes = attributes_override.present? ? OpenStruct.new(attributes_override) : attributes

        if update_attributes.datecreated.present?
          xml.datecreated do
            xml.year parse_date(update_attributes.datecreated).year
            xml.month parse_date(update_attributes.datecreated).month
            xml.day parse_date(update_attributes.datecreated).day
          end

        end

        if update_attributes.dateposted.present?
          xml.dateposted do
            xml.year parse_date(update_attributes.dateposted).year
            xml.month parse_date(update_attributes.dateposted).month
            xml.day parse_date(update_attributes.dateposted).day
          end

        end

        xml.referenceno update_attributes.referenceno if update_attributes.referenceno.present?
        xml.termname update_attributes.termname if update_attributes.termname.present?
        if update_attributes.datedue.present?
          xml.datedue do
            xml.year parse_date(update_attributes.datedue).year
            xml.month parse_date(update_attributes.datedue).month
            xml.day parse_date(update_attributes.datedue).day
          end

        end

        if update_attributes.origdocdate.present?
          xml.origdocdate do
            xml.year parse_date(update_attributes.origdocdate).year
            xml.month parse_date(update_attributes.origdocdate).month
            xml.day parse_date(update_attributes.origdocdate).day
          end

        end

        xml.message update_attributes.message if update_attributes.message.present?
        xml.shippingmethod update_attributes.shippingmethod if update_attributes.shippingmethod.present?
        xml.shipto update_attributes.shipto if update_attributes.shipto.present?
        xml.billto update_attributes.billto if update_attributes.billto.present?
        xml.supdocid update_attributes.supdocid if update_attributes.supdocid.present?
        xml.externalid update_attributes.externalid if update_attributes.externalid.present?
        xml.basecurr update_attributes.basecurr if update_attributes.basecurr.present?
        xml.currency update_attributes.currency if update_attributes.currency.present?
        if update_attributes.exchratedate.present?
          xml.exchratedate do
            xml.year parse_date(update_attributes.exchratedate).year
            xml.month parse_date(update_attributes.exchratedate).month
            xml.day parse_date(update_attributes.exchratedate).day
          end

        end

        xml.exchratetype update_attributes.exchratetype if update_attributes.exchratetype.present?
        xml.exchrate update_attributes.exchrate if update_attributes.exchrate.present?
        xml.vsoepricelist update_attributes.vsoepricelist if update_attributes.vsoepricelist.present?
        if update_attributes.customfields.present? || update_attributes.to_h.except(*UPDATE_SOTRANSACTION_KEYS).present?
          xml.customfields do
            if update_attributes.customfields.present?
              update_attributes.customfields.presence&.each do |custom_field|
                xml.customfield do
                  xml.customfieldname custom_field[:customfieldname]
                  xml.customfieldvalue custom_field[:customfieldvalue]
                end
              end
            end

            if update_attributes.to_h.except(*UPDATE_SOTRANSACTION_KEYS).present?
              update_attributes.to_h.except(*UPDATE_SOTRANSACTION_KEYS).each do |name, value|
                xml.customfield do
                  xml.customfieldname name
                  xml.customfieldvalue value
                end
              end
            end
          end
        end

        xml.state update_attributes.state if update_attributes.state.present?
        xml.projectid update_attributes.projectid if update_attributes.projectid.present?

        if update_attributes.updatesotransitems.present?
          xml.updatesotransitems do
            Array.wrap(update_attributes.updatesotransitems).each do |attributes|
              if attributes.line_num.present?
                item_name = "updatesotransitem"
                line_num = attributes.delete_field("line_num")
              else
                item_name = "sotransitem"
                line_num = nil
              end

              xml.send(item_name, { line_num: line_num }.compact) do
                xml.bundlenumber attributes.bundlenumber if attributes.bundlenumber.present?
                xml.itemid attributes.itemid if attributes.itemid.present?
                xml.itemdesc attributes.itemdesc if attributes.itemdesc.present?
                xml.taxable attributes.taxable if attributes.taxable.present?
                xml.warehouseid attributes.warehouseid if attributes.warehouseid.present?
                xml.quantity attributes.quantity if attributes.quantity.present?
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
                            xml.year parse_date(attributes.itemexpiration).year
                            xml.month parse_date(attributes.itemexpiration).month
                            xml.day parse_date(attributes.itemexpiration).day
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
                    xml.year parse_date(attributes.revrecstartdate).year
                    xml.month parse_date(attributes.revrecstartdate).month
                    xml.day parse_date(attributes.revrecstartdate).day
                  end

                end

                if attributes.revrecenddate.present?
                  xml.revrecenddate do
                    xml.year parse_date(attributes.revrecenddate).year
                    xml.month parse_date(attributes.revrecenddate).month
                    xml.day parse_date(attributes.revrecenddate).day
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

        if update_attributes.updatesubtotals.present?
          xml.updatesubtotals do
            Array.wrap(update_attributes.updatesubtotals).each do |update_attributes|
              xml.updatesubtotal do
                xml.description update_attributes.description
                xml.total update_attributes.total
                xml.absval update_attributes.absval if update_attributes.absval.present?
                xml.percentval update_attributes.percentval if update_attributes.percentval.present?
                xml.locationid update_attributes.locationid if update_attributes.locationid.present?
                xml.departmentid update_attributes.departmentid if update_attributes.departmentid.present?
                xml.projectid update_attributes.projectid if update_attributes.projectid.present?
                xml.customerid update_attributes.customerid if update_attributes.customerid.present?
                xml.vendorid update_attributes.vendorid if update_attributes.vendorid.present?
                xml.employeeid update_attributes.employeeid if update_attributes.employeeid.present?
                xml.classid update_attributes.classid if update_attributes.classid.present?
                xml.itemid update_attributes.itemid if update_attributes.itemid.present?
                xml.contractid update_attributes.contractid if update_attributes.contractid.present?
                if update_attributes.customfields.present? || update_attributes.to_h.except(*UPDATESUBTOTAL_KEYS).present?
                  xml.customfields do
                    if update_attributes.customfields.present?
                      update_attributes.customfields.presence&.each do |custom_field|
                        xml.customfield do
                          xml.customfieldname custom_field[:customfieldname]
                          xml.customfieldvalue custom_field[:customfieldvalue]
                        end
                      end
                    end

                    if update_attributes.to_h.except(*UPDATESUBTOTAL_KEYS).present?
                      update_attributes.to_h.except(*UPDATESUBTOTAL_KEYS).each do |name, value|
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
