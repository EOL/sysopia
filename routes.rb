get "/css/:filename.css" do
  scss :"sass/#{params[:filename]}"
end

get "/" do
  stats = Stat.last_month
  ct = Sysopia::ChartTable.new(stats)  
  @matrics_data = ct.matrics.to_json
  
  haml :home
end

