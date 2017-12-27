module SphyGmo
  module Card
    def self.search!(member_id: , seq_mode: , card_seq: )
      SphyGmo.gmo_site.search_card(member_id: member_id, seq_mode: seq_mode, card_seq: card_seq)
    rescue GMO::Payment::APIError => e
      raise SphyGmo::APIError.new(e)
    end

    def self.save!(member_id: ,token: ,card_seq: nil ,default_flag: ,seq_mode: )
      SphyGmo.gmo_site.save_card({
          member_id: member_id,
          token: token,
          card_seq: card_seq,
          default_flag: default_flag,
          seq_mode: seq_mode
        }.delete_if{|_,v| v.nil?})
    rescue GMO::Payment::APIError => e
      raise SphyGmo::APIError.new(e)
    end

    def self.delete!(member_id: , seq_mode: , card_seq: )
      SphyGmo.gmo_site.delete_card(member_id: member_id, seq_mode: seq_mode, card_seq: card_seq)
    rescue GMO::Payment::APIError => e
      raise SphyGmo::APIError.new(e)
    end
  end
end
