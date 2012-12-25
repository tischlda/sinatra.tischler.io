class User
  @@users = {
    david: {
      givenName: 'David',
      surName: 'Tischler',
      fullName: 'David Tischler',
      phone: '+61 434 762342',
      email: 'david@tischler.io',
      url: 'http://www.tischler.io/david'
    }
  }

  def User.find_by_name name
    return @@users[name.to_sym]
  end
end