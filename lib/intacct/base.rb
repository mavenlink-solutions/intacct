module Intacct
  Base = Struct.new(:client, :attributes) do
    include Intacct::Actions

    DATE_FORMAT = "%m/%d/%Y".freeze

    attr_accessor :client, :sent_xml, :intacct_action, :api_name, :errors, :raw_response

    delegate :formatted_error_message, to: :class

    def self.build(client, options = {})
      new(client, options)
    end

    def initialize(client, *args)
      @client = client
      args[0] = OpenStruct.new(args[0]) if args[0].is_a? Hash
      super(client, *args)
    end

    def create_name
      "create_#{self.class.name.demodulize.underscore}"
    end

    def create_xml(_xml)
      raise NotImplementedError, "This model does not support create."
    end

    def update_xml(_xml)
      raise NotImplementedError, "This model does not support update."
    end

    def id_attribute
      self.class.id_attribute
    end

    def method_missing(method_name, *args)
      stripped_method_name = method_name.to_s.gsub(/=$/, "")

      if stripped_method_name.to_sym.in? attributes.to_h.keys
        attributes.send(method_name, *args)
      else
        super method_name, *args
      end
    end

    def respond_to_missing?(method_name, *args)
      if method_name.in? attributes.to_h.keys
        true
      else
        super method_name, *args
      end
    end

    def api_name
      self.class.api_name
    end

    def persisted?
      !!attributes["recordno"]
    end

    protected

    def format_date(date_object)
      return if date_object.blank?

      date_object = parse_date(date_object)

      if date_object.is_a?(Date) || date_object.is_a?(Time)
        date_object.strftime(DATE_FORMAT)
      else
        date_object
      end
    end

    def parse_date(date_object)
      if date_object.is_a?(String)
        Date.strptime(date_object, DATE_FORMAT)
      else
        date_object
      end
    end

    private

    def read_only_fields
      self.class.read_only_fields
    end

    def attributes_to_xml(xml, key, value)
      if value.is_a?(Hash)
        xml.send(key) do
          value.each do |k, v|
            attributes_to_xml(xml, k, v)
          end
        end
      elsif value.is_a?(Array)
        value.each do |val|
          val.each do |k, v|
            attributes_to_xml(xml, k, v)
          end
        end
      else
        xml.send(key, value)
      end
    end

    def sliced_attributes
      attributes.to_h.except(*read_only_fields, :whenmodified)
    end

    %w[invoice bill vendor customer project].each do |type|
      define_method "intacct_#{type}_prefix" do
        Intacct.send("#{type}_prefix")
      end
    end

    def successful?
      if (status = response.at("//result//status")) && (status.content == "success")
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

    def self.id_attribute(attr = nil)
      @id_attribute = (attr || "#{name.to_s_demodulize.downcase}id") if attr
      @id_attribute
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

    def self.formatted_error_message(errors)
      [errors].flatten.map do |error|
        error["description"].presence || error["description2"] || "Undefined error"
      end .join(" ")
    end
  end
end
