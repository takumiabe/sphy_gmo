module SphyGmo
  module Transaction

    def self.entry!(order_id: , amount: , tax: , job_cd: )
      SphyGmo.gmo_shop.entry_tran(order_id: order_id, amount: amount, tax: tax, job_cd: job_cd)
    rescue GMO::Payment::APIError => e
      raise SphyGmo::APIError.new(e)
    end

    def self.execute!(
        order_id: ,
        member_id: , seq_mode: 0, card_seq: 0,
        access_id: ,  access_pass: ,
        method: PAYMENT_METHOD, pay_times: nil
        )
      SphyGmo.gmo_site.exec_tran(
        order_id: order_id,
        member_id: member_id, seq_mode: seq_mode, card_seq: card_seq,
        access_id: access_id, access_pass: access_pass,
        method: method, pay_times: pay_times,
        )
    rescue GMO::Payment::APIError => e
      raise SphyGmo::APIError.new(e)
    end
  end
end
