require 'csv'

module SphyGmo
  ErrorInfo = Struct.new('ErrorInfo', :code, :info, :message) do |s|
    class << s
      attr_accessor :all

      def parse(v)
        v = v.send(:error_info) if v.respond_to?(:error_info)
        infos = case v
                when Hash
                  v['ErrInfo'].split('|')
                when String
                  [v]
                when Array
                  v
                else
                  raise ArgumentError.new("#{self} cannot parse #{v.inspect}")
                end
        infos.map{|code| self[code]}
      end

      def [](code)
        all[code]
      end

      def all
        @all ||= init_all
      end

      private

      def init_all
        all = {}
        CSV
          .foreach(SphyGmo.path_to_resources 'assets/gmo_error_codes.csv')
          .map{|row| ErrorInfo.new(*row).freeze }
          .each{|err| all[err.info] = err }
        all.freeze
      end
    end
  end
end
