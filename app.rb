post '/incoming' do
  mail = Mail.new(params[:message])
  p params
  p mail
  p mail.body
  p mail.subject
  'success'
end
