# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

password = 'toto42'

@family = Family.create

# Create Members

@dimitri = User.new(nickname: 'keny', first_name: 'Dimitri', last_name: 'Jorge', email: 'dimitri@yopmail.fr', password: password, password_confirmation: password)
@dimitri.family = @family
@dimitri.last_sign_in_at = Time.now
@dimitri.save!

@jose = User.new(nickname: 'rodrig_d', first_name: 'Jose', last_name: 'Rodrigues', email: 'jose@yopmail.fr', password: password, password_confirmation: password)
@jose.family = @family
@jose.last_sign_in_at = 2.days.ago
@jose.save!

@julien = User.new(nickname: 'lifely', first_name: 'Julien', last_name: 'Di-marco', email: 'julien@yopmail.fr', password: password, password_confirmation: password)
@julien.family = @family
@julien.last_sign_in_at = 2.hours.ago
@julien.save!

@charles = User.new(nickname: 'furyfeuille', first_name: 'Charles', last_name: 'Circlaeys', email: 'charles@yopmail.fr', password: password, password_confirmation: password)
@charles.family = @family
@charles.last_sign_in_at = 1.week.ago
@charles.save!

@younes = User.new(nickname: 'yoones', first_name: 'Younes', last_name: 'Serraj', email: 'younes@yopmail.fr', password: password, password_confirmation: password)
@younes.family = @family
@younes.last_sign_in_at = 1.year.ago
@younes.save!

@nicolas = User.new(nickname: 'berhau_n', first_name: 'Nicolas', last_name: 'Berhault', email: 'nicolas@yopmail.fr', password: password, password_confirmation: password)
@nicolas.family = @family
@nicolas.last_sign_in_at = 1.minute.ago
@nicolas.save!

# Add some positions

@dimitri.positions << Position.create(latitude: 48.81561, longitude: 2.363155) # Epitech
@dimitri.positions << Position.create(latitude: 53.424571, longitude: -6.243839)
@dimitri.positions << Position.create(latitude: 53.34471, longitude: -6.262379)
@dimitri.positions << Position.create(latitude: 53.332536, longitude: -6.279081)

@jose.positions << Position.create(latitude: 48.81561, longitude: 2.363155) # Epitech
@jose.positions << Position.create(latitude: 48.811322, longitude: 2.362779)

@julien.positions << Position.create(latitude: 48.81561, longitude: 2.363155) # Epitech
@julien.positions << Position.create(latitude: 33.783428, longitude: -118.115129) # Long beach

@charles.positions << Position.create(latitude: 48.81561, longitude: 2.363155) # Epitech
@charles.positions << Position.create(latitude: 33.783428, longitude: -118.115129) # Long beach
@charles.positions << Position.create(latitude: 33.761845, longitude: -118.157787)

@younes.positions << Position.create(latitude: 48.81561, longitude: 2.363155) # Epitech

@nicolas.positions << Position.create(latitude: 48.81561, longitude: 2.363155) # Epitech
@nicolas.positions << Position.create(latitude: 33.138521, longitude: -117.153397) # San marcos

