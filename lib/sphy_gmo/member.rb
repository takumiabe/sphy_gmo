module SphyGmo
  module Member
    def self.search!(member_id: )
      SphyGmo.gmo_site.search_member(member_id: member_id)
    rescue GMO::Payment::APIError => e
      raise SphyGmo::APIError.new(e)
    end

    def self.save!(member_id: , member_name: , seq_mode: )
      SphyGmo.gmo_site.save_member(member_id: member_id, member_name: member_name, seq_mode: seq_mode)
    rescue GMO::Payment::APIError => e
      raise SphyGmo::APIError.new(e)
    end

    def self.delete!(member_id: )
      SphyGmo.gmo_site.delete_member(member_id: member_id)
    rescue GMO::Payment::APIError => e
      raise SphyGmo::APIError.new(e)
    end
  end
end
