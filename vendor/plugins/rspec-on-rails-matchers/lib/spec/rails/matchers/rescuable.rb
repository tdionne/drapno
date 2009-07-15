module Spec
  module Rails
    module Matchers
      class RescueExceptionWith
        def initialize(exception, options)
          @exception = exception
          raise ArgumentError unless options.is_a?(Hash) && options.has_key?(:with)
          @method = options[:with]
        end
        
        def matches?(rescuable_instance)
          rescuable_instance.handler_for_rescue(@exception) == rescuable_instance.method(@method)
        end
        
        def failure_message_for_should
          "expected #{@exception.class.inspect} to be rescued with ##{@method}"
        end
        
        def failure_message_for_should_not
          "expected #{@exception.class.inspect} NOT to be rescued with ##{@method}"
        end
      end
      
      # Checks that the receiver will rescue an exception instance with the specified handler
      # 
      #   object.should rescue_exception(StandardError.new, :with => :handler_method)
      def rescue_exception(exception, options)
        RescueExceptionWith.new(exception, options)
      end
    end
  end
end

