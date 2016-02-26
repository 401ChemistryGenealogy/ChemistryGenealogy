# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!([
  {
    password: 'testPassword', email: 'testEmail@email.ca', password_digest: 'pword',
    first_name: 'first', last_name: 'last', approved: true
  },
  {
    password: 'admin', email: 'tlowary@ualberta.ca', password_digest: 'pword',
    first_name: 'todd', last_name: 'lowary', approved: true
  }
])

# add Todd Lowary as an admin
Admin.create!([
    {users_id: 2, approved: true}
])

# add Todd Lowary's information

Institution.create!([
    {name: 'university of alberta', approved: true}
])

Person.create!([
    {name: 'todd lowary', position: 'professor', institution_id: 1, approved: true}
])

Degree.create!([
    {year: 1993, institution_id: 1, approved: true}
])

Supervisor.create!([
    {name: 'ole hindsgaul', person_id: 1, degree_id: 1, approved: true}
])

# add Wei Shi's information

Institution.create!([
    {name: 'johns hopkins university', approved: true},
    {name: 'university of arkansas', approved: true}
])

Person.create!([
    {name: 'wei shi', position: 'assistant professor', institution_id: 3, approved: true}
])

Degree.create!([
    {year: 2008, institution_id: 1, approved: true}
])

Supervisor.create!([
    {name: 'todd lowary', person_id: 2, degree_id: 2}
])
