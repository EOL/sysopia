get "/css/:filename.css" do
  scss :"sass/#{params[:filename]}"
end

get "/" do
  data = Stat.last_month
  ct = Sysopia::ChartTable.new(data)
  @mem_data = ct.table("memory_taken")
  @load_data = ct.table("load_one")
  @ioread_data = ct.table("io_read")
  @iowrite_data = ct.table("io_write")
  haml :home
end

