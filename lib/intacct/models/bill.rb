module Intacct
  module Models
    class Bill < Intacct::Base
      attr_accessor :customer_data

      api_name 'APBILL'

      # define_hook :custom_bill_fields, :bill_item_fields

      def create
        return false if attributes.payment.intacct_system_id.present?

        # Need to create the customer if one doesn't exist
        unless attributes.customer.intacct_system_id
          intacct_customer = Intacct::Customer.new attributes.customer
          raise 'Could not grab Intacct customer data' unless intacct_customer.create
        end

        # Create vendor if we have one and not in Intacct
        if attributes.vendor && attributes.vendor.intacct_system_id.blank?
          intacct_vendor = Intacct::Vendor.new attributes.vendor
          raise 'Could not create vendor' unless intacct_vendor.create

          attributes.vendor = intacct_vendor.attributes
        end

        send_xml('create') do |xml|
          xml.function(controlid: 'f1') do
            xml.send('create_bill') do
              bill_xml xml
            end
          end
        end

        successful?
      end

      def delete
        return false unless attributes.payment.intacct_system_id.present?

        send_xml('delete') do |xml|
          xml.function(controlid: '1') do
            xml.delete_bill(externalkey: 'false', key: attributes.payment.intacct_key)
          end
        end

        successful?
      end

      def intacct_object_id
        "#{intacct_bill_prefix}#{attributes.payment.id}"
      end

      def bill_xml(xml)
        xml.vendorid attributes.vendor.intacct_system_id
        xml.datecreated do
          xml.year attributes.payment.created_at.strftime('%Y')
          xml.month attributes.payment.created_at.strftime('%m')
          xml.day attributes.payment.created_at.strftime('%d')
        end
        xml.dateposted do
          xml.year attributes.payment.created_at.strftime('%Y')
          xml.month attributes.payment.created_at.strftime('%m')
          xml.day attributes.payment.created_at.strftime('%d')
        end
        xml.datedue do
          xml.year attributes.payment.paid_at.strftime('%Y')
          xml.month attributes.payment.paid_at.strftime('%m')
          xml.day attributes.payment.paid_at.strftime('%d')
        end
        run_hook :custom_bill_fields, xml
        run_hook :bill_item_fields, xml
      end

      def set_intacct_system_id
        attributes.payment.intacct_system_id = intacct_object_id
      end

      def set_intacct_key(key)
        attributes.payment.intacct_key = key
      end

      def delete_intacct_system_id
        attributes.payment.intacct_system_id = nil
      end

      def delete_intacct_key
        attributes.payment.intacct_key = nil
      end

      def set_date_time(type)
        return unless %w[create update delete].include? type

        attributes.payment.send("intacct_#{type}d_at=", DateTime.now) if attributes.payment.respond_to? :"intacct_#{type}d_at"
      end
    end
  end
end
