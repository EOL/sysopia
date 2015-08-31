require 'sinatra/contrib'

get "/css/:filename.css" do
  scss :"sass/#{params[:filename]}"
end

get "/" do
  Time.zone = "UTC"
  Chronic.time_class = Time.zone
  
  time_window = params[:time_window]
  offset      = params[:offset]
  length      = params[:length]
  start       = params[:start]  
  end_        = params[:end]
  ago         = params[:ago]
  page        = params[:page]

  time_window.to_s.gsub!(/_/, ' ')
  offset.to_s.gsub!(/_/, ' ')
  length.to_s.gsub!(/_/, ' ')
  start.to_s.gsub!(/_/, ' ')
  end_.to_s.gsub!(/_/, ' ')
  ago.to_s.gsub!(/_/, ' ')  
  page.to_s.gsub!(/_/, ' ')

  Stat.degrade_year_old_data

  if time_window.present?
  	stats, end_, time_diff = Stat.time_window_and_offset(time_window, offset)
  elsif start.present? && length.present?
  	stats, end_, time_diff = Stat.start_and_length(start, length)
  elsif start.present?  	
  	stats, end_, time_diff = Stat.start_and_end(start, end_)
  elsif ago.present?    
    stats, end_, time_diff  = Stat.ago(ago)
  elsif page.present?    
    stats, end_, time_diff  = Stat.start_and_end(page, end_)
  else 	 	
  	redirect '/?page=24_hours_ago'
  end

  ct = Sysopia::ChartTable.new(stats)  
  @matrics_data = ct.matrics.to_json
  @previous_timestamp = end_ || false
  @real_time = time_diff <= Stat::DAY
  
  json_data = {:stats => ct.matrics, :previous_timestamp => @previous_timestamp}.to_json

  respond_to do |format|
    format.json { json_data }
    format.html { haml :home }
  end
  
end

