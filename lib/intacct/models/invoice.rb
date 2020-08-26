module Intacct
  module Models
    class Invoice < Intacct::Base
      attr_accessor :customer_data

      api_name "ARINVOICE"

      def create
        return false if attributes.invoice.intacct_system_id.present?

        # Need to create the customer if one doesn't exist
        intacct_customer = Intacct::Customer.new attributes.customer
        unless attributes.customer.intacct_system_id.present?
          raise "Could not create customer" unless intacct_customer.create
        end

        if intacct_customer.get
          attributes.customer = intacct_customer.attributes
          @customer_data = intacct_customer.data
        else
          raise "Could not grab Intacct customer data"
        end

        # Create vendor if we have one and not in Intacct
        if attributes.vendor && attributes.vendor.intacct_system_id.blank?
          intacct_vendor = Intacct::Vendor.new attributes.vendor
          if intacct_vendor.create
            attributes.vendor = intacct_vendor.attributes
          else
            raise "Could not create vendor"
          end
        end

        send_xml("create") do |xml|
          xml.function(controlid: "f1") do
            xml.create_invoice do
              invoice_xml xml
            end
          end
        end

        successful?
      end

      def delete
        return false unless attributes.invoice.intacct_system_id.present?

        send_xml("delete") do |xml|
          xml.function(controlid: "1") do
            xml.delete_invoice(externalkey: "false", key: attributes.invoice.intacct_key)
          end
        end

        successful?
      end

      def intacct_object_id
        "#{intacct_invoice_prefix}#{attributes.invoice.id}"
      end

      def invoice_xml(xml)
        xml.customerid attributes.customer.intacct_system_id.to_s
        xml.datecreated do
          xml.year attributes.invoice.created_at.strftime("%Y")
          xml.month attributes.invoice.created_at.strftime("%m")
          xml.day attributes.invoice.created_at.strftime("%d")
        end

        termname = customer_data.termname
        xml.termname termname.present? ? termname : "Net 30"

        xml.invoiceno intacct_object_id
        run_hook :custom_invoice_fields, xml
      end

      def set_intacct_system_id
        attributes.invoice.intacct_system_id = intacct_object_id
      end

      def set_intacct_key(key)
        attributes.invoice.intacct_key = key
      end

      def delete_intacct_system_id
        attributes.invoice.intacct_system_id = nil
      end

      def delete_intacct_key
        attributes.invoice.intacct_key = nil
      end

      def set_date_time(type)
        if %w[create update delete].include? type
          attributes.invoice.send("intacct_#{type}d_at=", DateTime.now) if attributes.invoice.respond_to? :"intacct_#{type}d_at"
        end
      end
    end
  end
end
