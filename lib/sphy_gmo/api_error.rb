require 'csv'

module SphyGmo

  ErrorInfo = Struct.new('ErrorInfo', :code, :info, :message) do |s|
    def s.parse(v)
      v = v.send(:error_info) if v.respond_to?(:erro_info)
      infos = case v
              when Hash
                v['ErrInfo'].split('|')
              when String
                [v]
              when Array
                v
              end
      infos.map{|code| self[code]}
    end

    class << self
      attr_accessor :lookuptable

      def [](code)
        @lookuptable ||= init_lookuptable
        @lookuptable[code]
      end

      def init_lookuptable
        lookuptable = {}
        CSV
          .foreach(SphyGmo.path_to_resources 'assets/gmo_error_codes.csv')
          .map{|row| ErrorInfo.new(*row).freeze }
          .each{|err| lookuptable[err.info] = err }
        lookuptable.freeze
      end
    end
  end

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

    def inspect
      "#<#{self.class.name}:#{self.object_id} #{@errors.inspect}>"
    end
  end
end
