# coding: utf-8

puts 'Seeding the database...'

[
  { en: 'Art & Design', cy: 'Celf a Dylunio' },
  { en: 'Music', cy: 'Cerddoriaeth' },
  { en: 'Publishing & Journalism', cy: 'Cyhoeddi a Newyddiaduraeth' },
  { en: 'Film & Media', cy: 'Ffilm a Chyfryngau' },
  { en: 'Welsh Language Promotion', cy: 'Hyrwyddo\'r Gymraeg' },
  { en: 'Technology', cy: 'Technoleg' },
  { en: 'Theatre & Performance', cy: 'Theatr a Pherfformio' },
].each do |name|
   category = Category.find_or_initialize_by(name_en: name[:en])
   category.update_attributes({
     name_cy: name[:cy]
   })
   category.save
 end

{
  company_name: 'Heliwm',
  company_logo: '/assets/heliwm/svg/heliwm-logo-head-light-02.svg',
  host: ENV['APP_DOMAIN'],
  base_domain: ENV['APP_DOMAIN'],
  base_url: "https://#{ENV['APP_DOMAIN']}",

  email_contact: 'post.heliwm@gmail.com',
  email_payments: 'post.heliwm@gmail.com',
  email_projects: 'post.heliwm@gmail.com',
  email_system: 'post.heliwm@gmail.com',
  email_no_reply: 'post.heliwm@gmail.com',
  facebook_url: "https://www.facebook.com/pages/Heliwm/290852144409671",
  facebook_app_id: ENV['FACEBOOK_APP_ID'],
  twitter_url: 'https://twitter.com/heliwm',
  twitter_username: "heliwm",
  mailchimp_url: 'https://heliwm.us3.list-manage.com/subscribe?u=9280b96de279697a8c2103ebd&id=feee12318c',
  mailchimp_api_key: '0682116d413eaeb2fbb512f48c4d3998-us3',
  catarse_fee: '0.07',
  support_forum: '',
  uservoice_secret_gadget: 'change_this',
  uservoice_key: 'uservoice_key',
  faq_url: '',
  feedback_url: '',
  terms_url: '',
  privacy_url: '',
  about_channel_url: '',
  instagram_url: '',
  blog_url: "",
  github_url: '',
  contato_url: ''
}.each do |name, value|
   conf = Configuration.find_or_initialize_by(name: name)
   conf.update_attributes({
     value: value
   })
end


Channel.find_or_create_by!(name: "Channel name") do |c|
  c.permalink = "sample-permalink"
  c.description = "Lorem Ipsum"
end


facebook = OauthProvider.find_or_initialize_by(name: 'facebook')
facebook.update_attributes({
  key: ENV['FACEBOOK_APP_ID'],
  secret: ENV['FACEBOOK_APP_SECRET'],
  path: 'facebook'
})

puts
puts '============================================='
puts ' Showing all Authentication Providers'
puts '---------------------------------------------'

OauthProvider.all.each do |conf|
  a = conf.attributes
  puts "  name #{a['name']}"
  puts "     key: #{a['key']}"
  puts "     secret: #{a['secret']}"
  puts "     path: #{a['path']}"
  puts
end


puts
puts '============================================='
puts ' Showing all entries in Configuration Table...'
puts '---------------------------------------------'

Configuration.all.each do |conf|
  a = conf.attributes
  puts "  #{a['name']}: #{a['value']}"
end

puts '---------------------------------------------'
puts 'Done!'
