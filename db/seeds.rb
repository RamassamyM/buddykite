require 'faker'

puts 'Destroying orders'
Order.destroy_all
puts 'Done !...'
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
users_last_name = ["le plus beau", "le bricoleur", "Peigney", "Vedette"]
photos = %w(https://yt3.ggpht.com/-L0qrF11Bdog/AAAAAAAAAAI/AAAAAAAAAAA/qzPYeLuune4/s900-c-k-no-mo-rj-c0xffffff/photo.jpg http://www.infodimanche.com/upload/www.infodimanche.com/evenements/2008/05/zero_de_conduite__bob_le_brico_A_2009214112118_600.jpg https://avatars0.githubusercontent.com/u/466015?v=3&s=400 https://i.ytimg.com/vi/Eb2UECN1WXQ/maxresdefault.jpg)

print 'Seeding users...'
4.times do |num|
  user = User.new(
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    first_name: users_first_name[num],
    last_name: users_last_name[num],
  )
  user.photo_url = photos[num]
  user.save!
  print 'seeded ' + user.first_name + ' ' + user.last_name + '.....'
end

admin = User.new(
  email: 'contact@gmail.com',
  password: 'buddykite',
  first_name: 'Christian',
  last_name: 'Villaescusa'
)
admin.photo_url = 'https://avatars1.githubusercontent.com/u/25774894?v=3&s=400'
admin.save!
print 'seeded ' + admin.first_name + ' ' + admin.last_name + '.....'

brice = User.new(
  email: 'brice-du-06@gmail.com',
  password: 'bricedenice',
  first_name: 'Bice',
  last_name: 'De Nice'
)
brice.photo_url = 'http://images.sudouest.fr/2016/01/04/57e100ab66a4bde778c6955a/default/1000/sur-le-tournage-brice-de-nice-3.jpg'
brice.save!
print 'seeded ' + brice.first_name + ' ' + brice.last_name + '.....'

igor = User.new(
  email: 'Igor-lebg-du-40@gmail.com',
  password: 'igordhossegor',
  first_name: 'Igor',
  last_name: 'D\'Hossegor'
)
igor.photo_url = 'https://i.skyrock.net/8574/11948574/pics/307677317_small.jpg'
igor.save!
print 'seeded ' + igor.first_name + ' ' + igor.last_name + '.....'

puts 'done seeding users.'

categories = %w(sail board harness)
print 'Seeding categories...'
categories.each do |category|
  Category.create!(name: category)
  print 'seeded ' + category + '...'
end
puts 'done seeding categories.'

print 'Seeding sizes...'
sizes_data = {
  sail: (4..19).to_a,
  harness: %w(xs s m l xl xxl),
  board: %w(128 130 132 133 134 135 136 137 138 139 140 141 142 143 144)
}

sizes_data.each do |key, value|
  sizes_category = Category.where(name: key)
  value.each do |size|
    size_to_save = Size.new
    if key == :sail
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
  sail: {
    brands: ['cabrinha', 'f one', 'gaastra', 'north kiteborading', 'slingshot', 'wainman'],
    models: ['apollo 2017', 'chaos 2017', 'bandit 10 2017', 'jekyl 2013', 'neo 2017', 'evo 2017'],
    photos: [
      'http://www.glissup.fr/18918-ph_large/cabrinha-apollo-2017-aile-seule.jpg',
      'http://www.glissup.fr/18915-ph_large/cabrinha-contra-2017-aile-seule.jpg',
      'http://www.glissup.fr/18901-ph_large/cabrinha-fx-2017-aile-seule.jpg',
      'http://www.glissup.fr/17154-ph_large/f-one-bandit-10-2017-aile-seule.jpg',
      'http://www.glissup.fr/18911-ph_large/cabrinha-chaos-2017-aile-seule.jpg'
    ]
  },
  board: {
    brands: ['cabrinha', 'f one', 'firewire', 'flysurfer', 'nuclear bords', 'slingshot'],
    models: ['spectrum 2017', 'trax hrd carbon', 'next 2016', 'fly split', 'kite baked potato', 'separa infinity'],
    photos: [
      'http://www.glissup.fr/16872-ph_large/cabrinha-spectrum-2017-h1.jpg',
      'http://www.glissup.fr/19697-ph_large/f-one-trax-hrd-carbon-complete-2017.jpg',
      'http://www.glissup.fr/8277-ph_large/flysurfer-fly-split-134x41cm.jpg',
      'http://www.glissup.fr/5666-ph_large/firewire-kite-baked-potato-diamond-tail-fst.jpg',
      'http://www.glissup.fr/12849-ph_large/foilboard-f-one-carbon-series-2016.jpg'
    ]
  },
  harness: {
    brands: ['cabrinha', 'dakine', 'ion', 'manera', 'mystic', 'ride engine'],
    models: ['c1 maniac 2016', 'c1 sulphure 2017', 'chameleon camo 2017', 'fusion 2017', 'vega 2017'],
    photos: [
      'http://www.glissup.fr/19587-ph_large/harnais-dakine-c1-maniac-2016.jpg',
      'http://www.glissup.fr/18403-ph_large/harnais-dakine-c1-sulphure-2017.jpg',
      'http://www.glissup.fr/18417-ph_large/harnais-dakine-vega-2017.jpg',
      'http://www.glissup.fr/16084-ph_large/harnais-dakine-nitrous-hd-2016.jpg',
      'http://www.glissup.fr/18407-ph_large/harnais-dakine-chameleon-camo-2017.jpg'
    ]
  }
}

addresses = ['107 cours balguerie stuttenberg Bordeaux', '1 place tourny Bordeaux', '3 allée de bristol 33000 Bordeaux', '4 allée d\'orléans 33000 bordeaux', '110 boulvard de la plage Arcachon', '1 allée des treys 33980 Audenge', '37 rue saint-rémi 33000 bordeaux']

categories.each do |category|
  gear_category = Category.where(name: category).first
  rand(3..10).times do
    gear = Gear.new
    gear.brand = gears_data[category.to_sym][:brands].sample
    gear.address = addresses.sample
    gear.model = gears_data[category.to_sym][:models].sample
    gear.price = rand(5..15)*100
    gear.description = Faker::Lorem.sentence
    gear.size = gear_category.sizes.sample
    gear.owner = User.all.sample
    gear.photo_url = gears_data[category.to_sym][:photos].sample
    gear.save!
    print '.'
  end
end

print 'done seeding gears!...'

puts 'Seeding orders...'

gears = Gear.all
users = User.all
reviews = ['Trop bien', 'Jt\'ais cassé', 'Pas mal', 'Nul...', 'Sa fart ?', 'C TRO B1']
20.times do |i|
  gear = gears.sample
  order = Order.new(
    user: users.sample,
    gear: gears.sample,
    start_at: Date.today + rand(0..10).day,
    end_at: Date.today + rand(11..20).day
  )
  order.reviews = reviews.sample
  case order.reviews
  when reviews[0]
    order.rating = 5
  when reviews[1]
    order.rating = 2
  when reviews[2]
    order.rating = 3
  when reviews[3]
    order.rating = 0
  when reviews[4]
    order.rating = 1
  when reviews[5]
    order.rating = 5
  end
  order.infos = "#{(gear.price / 100).round}€ " + Faker::Lorem.sentence
  order.save!
  print "..#{i + 1}"
end
print 'donne seeding orders!...'
