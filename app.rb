set :logging, true
set :bucket_name, ENV['MAIL2S3_BUCKET_NAME']

AWS::S3::Base.establish_connection!(
  :access_key_id => ENV['AMAZON_ACCESS_KEY_ID'],
  :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
)

post '/incoming' do
  mail = Mail.new(params[:message])
  now = Time.now
  dir = "mail2s3/#{ now.strftime('%Y%m%d') }"
  filename = "#{ mail.message_id } #{ mail.subject }"
  filename = "No subject #{ now.strftime('%H%M') }" if filename.blank?
  text = mail.text_part ? mail.text_part.body.to_s : nil
  html = mail.html_part ? mail.html_part.body.to_s : nil

  unless text || html
    if mail.content_type.downcase.include? 'text/plain'
      text = mail.body.to_s
    elsif mail.content_type.downcase.include? 'text/html'
      html = mail.body.to_s
    end
  end

  AWS::S3::S3Object.store("#{dir}/#{filename}.html", html, settings.bucket_name) if html && !html.blank?
  AWS::S3::S3Object.store("#{dir}/#{filename}.txt",  text, settings.bucket_name) if text && !text.blank?

  'success'
end
