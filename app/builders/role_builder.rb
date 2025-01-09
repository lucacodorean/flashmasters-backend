class RoleBuilder
  def self.build_role(rolename)
    Role.create!(name: rolename)
  end
end