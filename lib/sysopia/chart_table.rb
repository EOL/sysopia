module Sysopia
  class ChartTable
    def initialize(stats)
      @comps = Comp.all
      @stats = stats
    end

    def matrics 
      matrics_data = {}
      selected_matrics = ["load_one", "memory_taken", "io_read", "io_write"]
      selected_matrics.each do |matric_name|
        matrics_data[matric_name] = Sysopia::Stat::DATA[matric_name.to_sym].merge({ :name => matric_name, :comps => matric(matric_name) })
      end      
      matrics_data
    end

    def matric(matric_name)    
      comp_data = {}
      @comps.each do |comp|
        comp_data[comp.id] = { :name => comp.sensu_name, :data => [] }
      end      
      @stats.each do |stat|             
        point = { :x => (stat["timestamp"] + Sysopia.conf.timezone_offset)*1000, :y => stat[matric_name] }
        comp_data[stat["comp_id"]][:data] << point           
      end      
      comp_data.map { |key, value| value }
    end

    private      
  end
end
