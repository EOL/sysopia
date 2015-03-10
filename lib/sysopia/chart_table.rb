module Sysopia
  class ChartTable
    def initialize(data)
      @comps = Comp.to_hash
      @data = data
    end

    def table(stat)
      res = raw_data(stat)
      make_json(res)
    end

    private
    def make_json(res)
      res.each_with_object([]) do |a, ary|
        ary << { name: @comps[a[0]], color: "palette.color()", data: a[1] }
      end.to_json.gsub(/"(x|y|name|data|color|palette.color\(\))"/, '\1')
    end

    def raw_data(stat)
      res = []
      current_comp_id = nil
      data = []
      @data.each do |r|
        comp_id = r.comp_id
        current_comp_id = comp_id if current_comp_id.nil?
        datum = { x: r[:timestamp] + Sysopia.conf.timezone_offset, y: r[stat] }
        if current_comp_id == comp_id
          data << datum
        else
          res << [current_comp_id, sorted_data(data)]
          current_comp_id = comp_id
          data = [datum]
        end
      end
      res << [current_comp_id, sorted_data(data)]
      res.sort_by { |a, b| @comps.keys.index(a) * -1 }
    end

    def sorted_data(data)
      data.sort_by { |datum| datum[:x] }
    end
  end
end
