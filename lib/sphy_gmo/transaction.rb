module SphyGmo
  module Transaction
    def self.entry!(order_id: , amount: , tax: , job_cd: )
      SphyGmo.gmo_shop.entry_tran(order_id: order_id, amount: amount, tax: tax, job_cd: job_cd)
    rescue GMO::Payment::APIError => e
      raise SphyGmo::APIError.new(e)
    end
  end
end
