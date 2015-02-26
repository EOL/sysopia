get "/css/:filename.css" do
  scss :"sass/#{params[:filename]}"
end

get "/" do
  stat = "load_one"
  data = Stat.last_day
  @stat_data = SysTube::ChartTable.new(data).table(stat)
  haml :home
end

