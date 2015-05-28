# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Chest.create([{size: 'Large', color: 'Yellow'}, {size: 'Small', color: 'Orange'}])
User.create([{
  email: 'admin@appfolio.com',
  name: 'Bob Bobby',
  mobile_number: '817-817-8177',
  encrypted_password: (User.new(password: 'Appfolio55%').encrypted_password)
},
{
  email: 'guest@appfolio.com',
  name: 'Guest Guesser',
  mobile_number: '832-832-8322',
  encrypted_password: (User.new(password: 'Appfolio55%').encrypted_password)
}
])
