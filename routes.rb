get "/css/:filename.css" do
  scss :"sass/#{params[:filename]}"
end

get "/" do
  haml :home
end

