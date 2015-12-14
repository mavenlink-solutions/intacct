module Intacct
  class Base
    include Intacct::Support::Actions
    include Intacct::Support::DSL
    include Intacct::Support::Fields
    include Intacct::Support::XML

    attr_accessor  :client, :attributes
    attr_reader :recordno

    def self.build(client, attributes = {})
      self.new(client, attributes)
    end

    def initialize(client, attributes = {})
      @client     = client
      @attributes = HashWithIndifferentAccess.new(attributes)

      attributes.symbolize_keys.select { |k,v| self.class.fields.keys.include?(k) }.each do |k,v|
        send("#{k}=", v)
      end
      @recordno = attributes['recordno']
    end

    def create_xml(xml)
      raise NotImplementedError, 'This model does not support create.'
    end

    def update_xml(xml)
      raise NotImplementedError, 'This model does not support update.'
    end

    def method_missing(method_name, *args)
      stripped_method_name = method_name.to_s.gsub(/=$/, '')

      if stripped_method_name.in? self.attributes.keys
        self.attributes[method_name]
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

    def persisted?
      !!recordno
    end

    private

    %w(invoice bill vendor customer project).each do |type|
      define_method "intacct_#{type}_prefix" do
        Intacct.send("#{type}_prefix")
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

  end
end
