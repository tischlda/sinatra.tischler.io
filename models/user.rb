class User
  @@users = {
    david: {
      givenName: 'David',
      surName: 'Tischler',
      fullName: 'David Tischler',
      phone: '+61 434 762342',
      email: 'david@tischler.io',
      web: 'http://tischler.io/david',
      skype: 'david.tischler',
      facebook: 'dtischler',
      github: 'tischlda',
      stackoverflow: '54499',
      xing: 'David_Tischler',
      about: 'Give a man a fish and he will eat for a day. Teach him how to fish, and he will destroy a whole ecosystem.'
    }
  }

  def User.find_by_name name
    return @@users[name.to_sym]
  end
end