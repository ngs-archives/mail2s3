post '/incoming' do
  mail = Mail.new(params[:message])
  p mail
  'success'
end
