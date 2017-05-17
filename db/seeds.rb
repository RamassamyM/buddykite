require 'faker'

puts 'Destroying gears..'
Gear.destroy_all
puts 'Done !...'
puts 'Destroying sizes..'
Size.destroy_all
puts 'Done !...'
puts 'Destroying Categories..'
Category.destroy_all
puts 'Done !...'
puts 'Destroying users..'
User.destroy_all
puts 'Done !...'

users_first_name = %w(toto bob sylvain michel)
users_last_name = ["leplusbeau", "lebricoleur", "Peigney", "Vedette"]

print 'Seeding users...'
4.times do |num|
  user = User.new(
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    first_name: users_first_name[num],
    last_name: users_last_name[num],
  )
  user.save!
  print 'seeded ' + user.first_name + ' ' + user.last_name + '.....'
end
puts 'done seeding users.'

categories = %w(sails boards harnesses)
print 'Seeding categories...'
categories.each do |category|
  Category.create!(name: category)
  print 'seeded ' + category + '...'
end
puts 'done seeding categories.'

print 'Seeding sizes...'
sizes_data = {
  sails: (4..19).to_a,
  harnesses: %w(xs s m l xl xxl),
  boards: %w(128 130 132 133 134 135 136 137 138 139 140 141 142 143 144)
}

sizes_data.each do |key, value|
  sizes_category = Category.where(name: key)
  value.each do |size|
    size_to_save = Size.new
    if key == :sails
      size_to_save.name = "#{size} m²"
      size_to_save.category = sizes_category.first
      size_to_save.save!
      print '.'
    else
      size_to_save.name = size
      size_to_save.category = sizes_category.first
      size_to_save.save!
      print '.'
    end
  end
end
print 'done seeding sizes!...'


print 'seeding gears...'
gears_data = {
  sails: {
    brands: ['cabrinha', 'f one', 'gaastra', 'north kiteborading', 'slingshot', 'wainman'],
    models: ['apollo 2017', 'chaos 2017', 'bandit 10 2017', 'jekyl 2013', 'neo 2017', 'evo 2017']
  },
  boards: {
    brands: ['cabrinha', 'f one', 'firewire', 'flysurfer', 'nuclear bords', 'slingshot'],
    models: ['spectrum 2017', 'trax hrd carbon', 'next 2016', 'fly split', 'kite baked potato', 'separa infinity']
  },
  harnesses: {
    brands: ['cabrinha', 'dakine', 'ion', 'manera', 'mystic', 'ride engine'],
    models: ['c1 maniac 2016', 'c1 sulphure 2017', 'chameleon camo 2017', 'fusion 2017', 'vega 2017']
  }
}

categories.each do |category|
  gear_category = Category.where(name: category).first
  rand(3..10).times do
    gear = Gear.new
    gear.brand = gears_data[category.to_sym][:brands].sample
    gear.address = Faker::Address.street_address
    gear.model = gears_data[category.to_sym][:models].sample
    gear.price = rand(10000..50000)
    gear.description = Faker::Lorem.sentence
    gear.size = gear_category.sizes.sample
    gear.owner = User.all.sample
    gear.save!
    print '.'
  end
end
print 'done seeding gears!...'
