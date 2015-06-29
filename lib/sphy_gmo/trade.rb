module SphyGmo
  module Trade
    def self.search!(order_id: )
      SphyGmo.gmo_shop.search_trade(order_id: order_id)
    rescue GMO::Payment::APIError => e
      raise SphyGmo::APIError.new(e)
    end
  end
end
