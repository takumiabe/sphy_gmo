require 'forwardable'
require 'webmock'

WebMock.disable! # デフォルトでブロックしてしまうので排除

module SphyGmo::Stub
  class << self
    extend Forwardable

    def modes
      @modes ||= [:disable]
    end

    def mode
      modes[-1]
    end

    def mode=(mode)
      update_stubbing(modes.last, mode)

      modes[-1] = mode
    end

    def stub(mode, &block)
      push(mode)
      ret = yield
      pop
      ret
    end

    def push(mode)
      update_stubbing(modes.last, mode)
      modes.push(mode)
    end

    def pop
      ret = modes.pop
      update_stubbing(ret, modes.last)
      ret
    end

    def update_stubbing(prev, mode)
      if prev != mode
        case mode
        when :enable
          enable_stubbing
        when :disable
          disable_stubbing
        else
          raise "stub mode must be :enable or :disable"
        end
      end
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
      WebMock.reset!
      WebMock.disable!
    end

    def stub_entry_tran(success: )
      target_url = "https://#{SphyGmo.configuration.host}/payment/EntryTran.idPass"
      if success
        body = Rack::Utils.build_nested_query(AccessID: rand(0..10000), AccessPass: rand(0..10000))
      else
        err = SphyGmo::ErrorInfo.all.values.sample
        body = Rack::Utils.build_nested_query(ErrCode: err.code ,ErrInfo: err.info)
      end
      WebMock.stub_request(:post, target_url).to_return(status: 200, body: body)
    end
  end
end
