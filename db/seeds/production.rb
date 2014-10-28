puts "Adding Admin user..."

  User.find_or_create_by!(name: "Admin") do |u|
    u.nickname = "Admin"
    u.email = "admin@example.com"
    u.password = "password"
    u.password_confirmation = "password"
    u.admin = true
  end
