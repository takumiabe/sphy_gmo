require 'sphy_gmo/error_info'

module SphyGmo
  class APIError < GMO::Payment::APIError
    attr_reader :errors, :record
    def initialize(api_error, record = nil)
      @errors = ErrorInfo.parse(api_error)
      @record = record
    end

    def message
      messages.join(' ')
    end

    def messages
      @errors.map(&:message)
    end

    def raw_errinfo
      @errors.map(&:info).join('|')
    end

    def raw_errcode
      @errors.map(&:code).join('|')
    end

    def inspect
      "#<#{self.class.name}:#{self.object_id} #{@errors.inspect}>"
    end
  end
end
