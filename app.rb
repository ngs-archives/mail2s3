post '/incoming' do
  mail = Mail.new(params[:message])
  p params
  'success'
end
