require 'sinatra/contrib'

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
  	stats, end_ = Stat.start_and_end(start, end_)
  elsif ago.present?    
    stats = Stat.ago(ago, timestamp)
  else 	 	
  	redirect '/?start=24_hours_ago'
  end

  ct = Sysopia::ChartTable.new(stats)  
  @matrics_data = ct.matrics.to_json
  @previous_timestamp = end_
  
  json_data = {:stats => ct.matrics, :previous_timestamp => @previous_timestamp}.to_json

  respond_to do |format|
    format.json { json_data }
    format.html { haml :home }
  end
  
end

