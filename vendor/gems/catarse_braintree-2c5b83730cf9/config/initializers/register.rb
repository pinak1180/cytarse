begin
  route_proc = ->(backer) do
    CatarseBraintree::Engine.routes.url_helpers.review_braintree_path(backer)
  end

  PaymentEngines.register({
    name: 'braintree',
    review_path: route_proc,
    locale: 'en'
  })
rescue Exception => e
  puts "Error while registering payment engine: #{e}"
end
