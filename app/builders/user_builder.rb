class UserBuilder
  def self.build_user(role_name, name, email, password, is_admin)
    User.create!(
      name: name,
      email: email,
      password: password,
      role: Role.find_by(name: role_name),
      admin: is_admin
    )
  end
end