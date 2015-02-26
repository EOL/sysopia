class Comp < ActiveRecord::Base
  def self.to_hash
    @comp_hash ||= Comp.all.each_with_object({}) do |c, h|
      h[c.id] = c.sensu_name
    end.sort_by { |_k, v| v }.to_h
  end
end
