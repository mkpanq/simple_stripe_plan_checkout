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
end
