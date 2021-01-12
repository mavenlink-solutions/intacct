module Intacct
  class Response
    include Intacct::Callbacks

    attr_accessor :client, :body, :errors
    attr_reader :raw_response

    def initialize(client, options)
      @client = client
      @success = options[:success]
      @body = options[:body]
      @errors = options[:errors] || []
      @raw_response = options[:raw_response]
    end

    def success?
      @success
    end

    def error?
      @errors.any?
    end
  end
end
