# coding: utf-8

puts 'Seeding the database...'

[
  { pt: 'Arte', en: 'Art', cy: 'Celf' },
  { pt: 'Artes plásticas', en: 'Visual Arts', cy: 'Celf Weledol' },
  { pt: 'Circo', en: 'Circus', cy: 'Syrcas' },
  { pt: 'Comunidade', en: 'Community', cy: 'Cymuned' },
  { pt: 'Humor', en: 'Humor', cy: 'Hiwmor' },
  { pt: 'Quadrinhos', en: 'Comicbooks', cy: 'Llyfrau Comic' },
  { pt: 'Dança', en: 'Dance', cy: 'Dawns' },
  { pt: 'Design', en: 'Design', cy: 'Dylunio' },
  { pt: 'Eventos', en: 'Events', cy: 'Digwyddiadau' },
  { pt: 'Moda', en: 'Fashion', cy: 'Ffasiwn' },
  { pt: 'Gastronomia', en: 'Gastronomy', cy: 'Gastronomeg' },
  { pt: 'Cinema & Vídeo', en: 'Film & Video', cy: 'Ffilm & Fideo' },
  { pt: 'Jogos', en: 'Games', cy: 'Gemau' },
  { pt: 'Jornalismo', en: 'Journalism', cy: 'Newyddiadureg' },
  { pt: 'Música', en: 'Music', cy: 'Cerddoriaeth' },
  { pt: 'Fotografia', en: 'Photography', cy: 'Ffotograffeg' },
  { pt: 'Ciência e Tecnologia', en: 'Science & Technology', cy: 'Gwyddoniaeth & Thechnoleg' },
  { pt: 'Teatro', en: 'Theatre', cy: 'Theatr' },
  { pt: 'Esporte', en: 'Sport', cy: 'Chwaraeon' },
  { pt: 'Web', en: 'Web', cy: 'Y We' },
  { pt: 'Carnaval', en: 'Carnival', cy: 'Carnifal' },
  { pt: 'Arquitetura & Urbanismo', en: 'Architecture & Urbanism', cy: 'Pensaerniaeth' },
  { pt: 'Literatura', en: 'Literature', cy: 'Llenyddiaeth' },
  { pt: 'Mobilidade e Transporte', en: 'Mobility & Transportation', cy: 'Teithio' },
  { pt: 'Meio Ambiente', en: 'Environment', cy: 'Amgylchedd' },
  { pt: 'Negócios Sociais', en: 'Social Business', cy: 'Busnes Cymdeithasol' },
  { pt: 'Educação', en: 'Education', cy: 'Addysg' },
  { pt: 'Filmes de Ficção', en: 'Fiction Films', cy: 'Ffilmiau Ffuglen' },
  { pt: 'Filmes Documentários', en: 'Documentary Films', cy: 'Ffilmiau Dogfen' },
  { pt: 'Filmes Universitários', en: 'Experimental Films', cy: 'Ffilmiau Arbrofol' }
].each do |name|
   category = Category.find_or_initialize_by(name_pt: name[:pt])
   category.update_attributes({
     name_en: name[:en],
     name_cy: name[:cy]
   })
 end

{
  company_name: 'Heliwm',
  company_logo: '/assets/heliwm/svg/heliwm-logo-head-light-02.svg',
  host: ENV['APP_DOMAIN'],
  base_domain: ENV['APP_DOMAIN'],
  base_url: "http://#{ENV['APP_DOMAIN']}",

  email_contact: 'post.heliwm@gmail.com',
  email_payments: 'post.heliwm@gmail.com',
  email_projects: 'post.heliwm@gmail.com',
  email_system: 'post.heliwm@gmail.com',
  email_no_reply: 'post.heliwm@gmail.com',
  facebook_url: "https://www.facebook.com/pages/Heliwm/290852144409671",
  facebook_app_id: '247011378836795',
  twitter_url: 'http://twitter.com/heliwm',
  twitter_username: "heliwm",
  mailchimp_url: 'http://heliwm.us3.list-manage.com/subscribe?u=9280b96de279697a8c2103ebd&id=feee12318c',
  mailchimp_api_key: '0682116d413eaeb2fbb512f48c4d3998-us3',
  catarse_fee: '0.4',
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


OauthProvider.find_or_create_by!(name: 'facebook') do |o|
  o.key = '247011378836795'
  o.secret = '2f5f436bdbcd0fefaa03b260048ec0aa'
  o.path = 'facebook'
end

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
