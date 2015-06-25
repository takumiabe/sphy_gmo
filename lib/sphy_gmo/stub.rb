require 'webmock'

module SphyGmo
  class << self
    attr_accessor :stub

    def stub=(mode)
      if @stub != mode
        case mode
        when :enable
          enable_stubbing
        when :disable
          disable_stubbing
        else
          raise "stub mode must be :enable or :disable"
        end
      end

      @stub = mode
    end

    def enable_stubbing
      WebMock.enable!

      WebMock.stub_request(:any, SphyGmo.configuration.host)

      WebMock.stub_request(
        :post, "https://#{SphyGmo.configuration.host}/payment/SearchMember.idPass")
        .to_return(status: 200, body: '', headers: {})
      WebMock.stub_request(
        :post, "https://#{SphyGmo.configuration.host}/payment/SaveCard.idPass")
        .to_return(status: 200, body: '', headers: {})
    end

    def disable_stubbing
      WebMock.disable!
    end

    def stub_entry_tran(result)
      target_url = "https://#{SphyGmo.configuration.host}/payment/EntryTran.idPass"
      body = Rack::Utils.build_nested_query(result)

      stub_request(:post, target_url).to_return(status: 200, body: body)
    end
  end
end
