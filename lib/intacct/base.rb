module Intacct
  class Base < Struct.new(:client, :attributes)
    include Intacct::Actions

    attr_accessor  :client, :sent_xml, :intacct_action, :api_name, :errors

    def initialize(client, *args)
      @client = client
      args[0] = OpenStruct.new(args[0]) if args[0].is_a? Hash
      super(client, *args)
    end

    def self.build(client, options = {})
      self.new(client, options)
    end
    #
    # def self.get(client, key, options = {})
    #   send_xml(client, 'get') do |xml|
    #     xml.function(controlid: "f4") {
    #       xml.get(attributes: api_name, key: key) {
    #
    #         if options[:fields]
    #           xml.fields {
    #             fields.each do |field|
    #               xml.field field.to_s
    #             end
    #           }
    #         end
    #       }
    #     }
    #   end
    # end
    #
    # def self.read(client, key, options = {})
    #   send_xml(client, 'read') do |xml|
    #     xml.function(controlid: 'f4') {
    #       xml.read {
    #         xml.attributes api_name.upcase
    #         xml.keys key
    #         xml.fields '*'
    #         xml.returnFormat 'xml'
    #       }
    #     }
    #   end
    # end
    #
    # def self.read_by_query(client, query)
    #   send_xml(client, 'readByQuery') do |xml|
    #     xml.function(controlid: 'f4') {
    #       xml.readByQuery {
    #         xml.attributes api_name.upcase
    #         xml.query query
    #         xml.fields '*'
    #         xml.returnFormat 'xml'
    #       }
    #     }
    #   end
    # end

    # NOTE(AB): This is a WIP. Intacct is pedantic about the order of fields in the request
    #           We should probably specify the order of fields on the model and then rearrange
    #           the model attributes when preparing the request.
    # def create
    #   send_xml('create') do |xml|
    #     xml.function(controlid: '1') {
    #       xml.send("create_#{api_name}") {
    #
    #         xml.send("#{api_name}id", key)
    #
    #         attributes.to_h.each { |key, value|
    #
    #           attributes_to_xml(xml, key, value)
    #
    #         }
    #
    #       }
    #     }
    #   end
    # end
    #
    # def update
    #   send_xml('update') do |xml|
    #     xml.function(controlid: '1') {
    #       xml.send("update_#{api_name}", key: key) {
    #
    #         xml.send("#{api_name}id", key)
    #
    #         sliced_attributes.each { |key, value|
    #
    #           attributes_to_xml(xml, key, value)
    #
    #         }
    #
    #       }
    #     }
    #   end
    # end

    def key
      @key ||= (attributes.key || random_attributes_id)
    end

    def key=(value)
      attributes.key = value
    end

    def method_missing(method_name, *args, &block)
      stripped_method_name = method_name.to_s.gsub(/=$/, '')

      if stripped_method_name.to_sym.in? self.attributes.to_h.keys
        self.attributes.send(method_name, *args)
      else
        super method_name, *args
      end
    end

    def respond_to_missing?(method_name, *args)
      if method_name.in? self.attributes.to_h.keys
        true
      else
        super method_name, *args
      end
    end

    def api_name
      self.class.api_name
    end

    private

    def send_xml(action = nil, &block)
      self.class.send_xml(client, action, self, &block)
    end

    def read_only_fields
      self.class.read_only_fields
    end

    def attributes_to_xml(xml, key, value)
      if value.is_a?(Hash)
        xml.send(key) {
          value.each do |k,v|
            attributes_to_xml(xml, k, v)
          end
        }
      elsif value.is_a?(Array)
        value.each do |val|
          val.each do |k,v|
            attributes_to_xml(xml, k, v)
          end
        end
      else
        xml.send(key, value)
      end
    end

    def sliced_attributes
      attributes.to_h.except(*read_only_fields, :key, :whenmodified)
    end

    %w(invoice bill vendor customer project).each do |type|
      define_method "intacct_#{type}_prefix" do
        Intacct.send("#{type}_prefix")
      end
    end

    def successful?
      if status = response.at('//result//status') and status.content == "success"
        true
      else
        false
      end
    end

    def intacct_system_id
      intacct_attributes_id
    end

    def intacct_attributes_id
      attributes.id ? "#{intacct_customer_prefix}#{attributes.id}" : random_attributes_id
    end

    def random_attributes_id
      SecureRandom.random_number.to_s
    end


    #
    # Class Methods
    #

    def self.api_name(name = nil)
      @api_name ||= (name || self.name.to_s.demodulize.downcase)
    end

    def self.send_xml(client, action, model = nil, &block)
      builder = Intacct::XmlRequest.new(client, action, self, model)
      builder.build_xml(&block)
    end

    def self.read_only_fields(*args)
      if args.empty?
        @read_only_fields ||= Set.new
      else
        args.each do |arg|
          read_only_field arg
        end
      end
    end

    def self.read_only_field(name)
      name_sym = name.to_sym
      read_only_fields << name_sym
    end
  end
end
