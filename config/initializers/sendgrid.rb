begin
  if Rails.env.production?
    if ENV['MAIL_METHOD'] == 'letter_opener_web'
      ActionMailer::Base.delivery_method = :letter_opener_web
    else
      ActionMailer::Base.smtp_settings = {
      address: 'smtp.sendgrid.net',
      port: '587',
      authentication: :plain,
      user_name: CatarseSettings.get_without_cache(:sendgrid_user_name),
      password: CatarseSettings.get_without_cache(:sendgrid),
      domain: CatarseSettings.get_without_cache(:base_domain)
      }
      ActionMailer::Base.delivery_method = :smtp
    end
  end
rescue
  nil
end
