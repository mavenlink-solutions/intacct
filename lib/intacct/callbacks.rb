module Intacct
  module Callbacks
    extend ::ActiveSupport::Concern

    included do
      include Hooks
      include Hooks::InstanceHooks

      CALLBACK_ACTIONS = %w[get create update delete].freeze unless defined?(CALLBACK_ACTIONS)

      CALLBACK_ACTIONS.each do |action|
        send(:define_hook, "before_#{action}")
        send(:define_hook, "after_#{action}")
      end

      define_hook :after_send_xml
      define_hook :on_error
    end
  end
end
