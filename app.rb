post '/incoming' do
  mail = Mail.new(params[:message])
  filename = "#{ Time.now.strftime('%Y-%m/%d/%H-%M') } #{ mail.subject }"
  p filename
  'success'

end
