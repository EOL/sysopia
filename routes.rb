get "/css/:filename.css" do
  scss :"sass/#{params[:filename]}"
end

get "/" do
  time_window = params[:time_window]
  offset      = params[:offset]
  length      = params[:length]
  start       = params[:start]
  end_        = params[:end]
  ago         = params[:ago]

  time_window.to_s.gsub!(/_/, ' ')
  offset.to_s.gsub!(/_/, ' ')
  length.to_s.gsub!(/_/, ' ')
  start.to_s.gsub!(/_/, ' ')
  end_.to_s.gsub!(/_/, ' ')
  ago.to_s.gsub!(/_/, ' ')  

  if time_window.present? && offset.present?
  	stats = Stat.time_window_and_offset(time_window, offset)
  elsif start.present? && length.present?
  	stats = Stat.start_and_length(start, length)
  elsif start.present?  	
  	stats = Stat.start_and_end(start, end_)
  elsif ago.present?    
    stats = Stat.ago(ago)
  else 	 	
  	stats = Stat.last_day
  end

  ct = Sysopia::ChartTable.new(stats)  
  @matrics_data = ct.matrics.to_json
  
  haml :home
end

