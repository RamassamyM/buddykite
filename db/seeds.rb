require 'faker'

puts 'Destroying gears..'
Gear.destroy_all
puts 'Done !...'
puts 'Destroying Categories..'
Category.destroy_all
puts 'Done !...'
puts 'Destroying sizes..'
Size.destroy_all
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

categories = %w(sail board harness)
print 'Seeding categories...'
categories.each do |category|
  Category.create!(name: category)
  print 'seeded ' + category + '...'
end
puts 'done seeding categories.'

print 'seeding gears...'
gears_data = {
  sail: {
    brands: ['cabrinha', 'f one', 'gaastra', 'north kiteborading', 'slingshot', 'wainman'],
    models: ['apollo 2017', 'chaos 2017', 'bandit 10 2017', 'jekyl 2013', 'neo 2017', 'evo 2017']
  },
  board: {
    brands: ['cabrinha', 'f one', 'firewire', 'flysurfer', 'nuclear bords', 'slingshot'],
    models: ['spectrum 2017', 'trax hrd carbon', 'next 2016', 'fly split', 'kite baked potato', 'separa infinity']
  },
  harness: {
    brands: ['cabrinha', 'dakine', 'ion', 'manera', 'mystic', 'ride engine'],
    models: ['c1 maniac 2016', 'c1 sulphure 2017', 'chameleon camo 2017', 'fusion 2017', 'vega 2017']
  }
}

categories.each do |category|
  gear_category = Category.where(name: category)
  rand(3..10).times do
    gear = Gear.new(
      brand: gears_data[category.to_sym][:brands].sample,
      address: Faker::Address.street_address,
      model: gears_data[category.to_sym][:models].sample,
      price: rand(10000..50000),
      description: Faker::Lorem.sentence,
      category: gear_category.first,
      owner: User.all.sample
    )
    gear.save!
    print '.'
  end
end
print 'done!...'


puts 'Seeding sizes...'
sizes_data = {
  sail: (4..19).to_a,
  harness: %w(xs s m l xl xxl),
  board: %w(128 130 132 133 134 135 136 137 138 139 140 141 142 143 144)
}

sizes_data.each do |key, value|
  sizes_category = Category.where(name: key)
  size_to_save = Size.new
  value.each do |size|
    if key == :sail
      size_to_save.name = "#{size} m²"
    else
      size_to_save.name = size
    end
    size_to_save.category = sizes_category.first
  end
  size_to_save.save!
  print '.'
end
print 'done!...'
