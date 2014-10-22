begin
  if Rails.env.production?
    if ENV['MAIL_METHOD'] == 'letter_opener'
      ActionMailer::Base.delivery_method = :letter_opener
    else
      ActionMailer::Base.smtp_settings = {
      address: 'smtp.sendgrid.net',
      port: '587',
      authentication: :plain,
      user_name: Configuration[:sendgrid_user_name],
      password: Configuration[:sendgrid],
      domain: 'heroku.com'
      }
      ActionMailer::Base.delivery_method = :smtp
    end
  end
rescue
  nil
end
