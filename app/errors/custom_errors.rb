module CustomErrors
  class PayloadError < StandardError
    attr_reader :status

    def initialize
      super("Invalid Payload")
      @status = :bad_request
    end
  end

  class SignatureError < StandardError
    attr_reader :status

    def initialize
      super("Invalid Signature")
      @status = :bad_request
    end
  end

  class OrderNotFound < StandardError
    attr_reader :status

    def initialize
      super("Order not found")
      @status = :not_found
    end
  end

  class OrderAlreadyFulfilled < StandardError
    attr_reader :status

    def initialize
      super("Order already fulfilled")
      @status = :bad_request
    end
  end

  class CheckoutSessionNotFound < StandardError
    attr_reader :status

    def initialize
      super("Checkout session not found")
      @status = :not_found
    end
  end

  class SessionAlreadyCompleted < StandardError
    attr_reader :status

    def initialize
      super("Session already completed")
      @status = :bad_request
    end
  end
end
