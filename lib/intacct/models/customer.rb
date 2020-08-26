module Intacct
  module Models
    class Customer < Intacct::Base
      def create
        send_xml("create") do |xml|
          xml.function(controlid: "1") do
            xml.send("create_customer") do
              xml.customerid intacct_object_id
              xml.name attributes.name
              xml.comments
              xml.status "active"
            end
          end
        end

        successful?
      end

      def get(*fields)
        return false unless attributes.intacct_system_id.present?

        if fields.empty?
          fields = %i[
            customerid
            name
            termname
          ]
        end

        send_xml("get") do |xml|
          xml.function(controlid: "f4") do
            xml.get(attributes: "customer", key: intacct_system_id.to_s) do
              xml.fields do
                fields.each do |field|
                  xml.field field.to_s
                end
              end
            end
          end
        end

        if successful?
          @data = OpenStruct.new({
                                   id: response.at("//customer//customerid").content,
                                   name: response.at("//customer//name").content,
                                   termname: response.at("//customer//termname").content
                                 })
        end

        successful?
      end

      def update(updated_customer = false)
        @attributes = updated_customer if updated_customer
        return false unless attributes.intacct_system_id.present?

        send_xml("update") do |xml|
          xml.function(controlid: "1") do
            xml.update_customer(customerid: intacct_system_id) do
              xml.name attributes.name
              xml.comments
              xml.status "active"
            end
          end
        end

        successful?
      end

      def delete
        return false unless attributes.intacct_system_id.present?

        @response = send_xml("delete") do |xml|
          xml.function(controlid: "1") do
            xml.delete_customer(customerid: intacct_system_id)
          end
        end

        successful?
      end

      def intacct_object_id
        "#{intacct_customer_prefix}#{attributes.id}"
      end
    end
  end
end
