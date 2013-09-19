# encoding: utf-8

password = 'toto42'

@family = Family.create

# Create Members

@dimitri = User.new(nickname: 'keny', first_name: 'Dimitri', last_name: 'Jorge', email: 'jorge.dimitri@gmail.com', password: password, password_confirmation: password)
@dimitri.family = @family
@dimitri.last_sign_in_at = Time.now
@dimitri.save!

@jose = User.new(nickname: 'rodrig_d', first_name: 'Jose', last_name: 'Rodrigues', email: 'contact.jrodrigues@gmail.com', password: password, password_confirmation: password)
@jose.family = @family
@jose.last_sign_in_at = 2.days.ago
@jose.save!

@julien = User.new(nickname: 'lifely', first_name: 'Julien', last_name: 'Di-marco', email: 'juliendimarco@gmail.com', password: password, password_confirmation: password)
@julien.family = @family
@julien.last_sign_in_at = 2.hours.ago
@julien.save!

@charles = User.new(nickname: 'furyfeuille', first_name: 'Charles', last_name: 'Circlaeys', email: 'c.circlaeys@gmail.com', password: password, password_confirmation: password)
@charles.family = @family
@charles.last_sign_in_at = 1.week.ago
@charles.save!

@younes = User.new(nickname: 'yoones', first_name: 'Younes', last_name: 'Serraj', email: 'younes.serraj@gmail.com', password: password, password_confirmation: password)
@younes.family = @family
@younes.last_sign_in_at = 1.year.ago
@younes.save!

@nicolas = User.new(nickname: 'berhau_n', first_name: 'Nicolas', last_name: 'Berhault', email: 'gurki.epitech@gmail.com', password: password, password_confirmation: password)
@nicolas.last_sign_in_at = 1.minute.ago
@nicolas.save!

# --- Invite Nicolas
@invitation = Invitation.new(email: @nicolas.email)
@invitation.user = @dimitri
@invitation.family = @family
@invitation.save!
@invitation.accept! @nicolas

# Add some positions

# @dimitri.positions << Position.create(latitude: 48.81561, longitude: 2.363155) # Epitech
# @dimitri.positions << Position.create(latitude: 53.424571, longitude: -6.243839)
# @dimitri.positions << Position.create(latitude: 53.34471, longitude: -6.262379)
# @dimitri.positions << Position.create(latitude: 53.332536, longitude: -6.279081)

# @jose.positions << Position.create(latitude: 48.81561, longitude: 2.363155) # Epitech
# @jose.positions << Position.create(latitude: 48.811322, longitude: 2.362779) # Fratelos

# @julien.positions << Position.create(latitude: 48.81561, longitude: 2.363155) # Epitech
# @julien.positions << Position.create(latitude: 33.783428, longitude: -118.115129) # Long beach

# @charles.positions << Position.create(latitude: 48.81561, longitude: 2.363155) # Epitech
# @charles.positions << Position.create(latitude: 33.783428, longitude: -118.115129) # Long beach
# @charles.positions << Position.create(latitude: 33.761845, longitude: -118.157787)

# @younes.positions << Position.create(latitude: 48.81561, longitude: 2.363155) # Epitech

# @nicolas.positions << Position.create(latitude: 48.81561, longitude: 2.363155) # Epitech
# @nicolas.positions << Position.create(latitude: 33.138521, longitude: -117.153397) # San marcos

# Add some messages

post = @family.posts.new(message: "Le grand jour c'est bientôt")
post.author = @dimitri
post.save

post = @family.posts.new(message: "iOS 7 est vraiment bien fait")
post.author = @charles
post.save

post = @family.posts.new(message: "Salut !")
post.author = @jose
post.save

post = @family.posts.new(message: "Le nouveau Game of Thrones déchire!")
post.author = @julien
post.save

post = @family.posts.new(message: "José il faudrait aller à carrefour")
post.author = @younes
post.save

# Add some events

now = Time.now
past_event = Event.new(title: 'Travailler sur le projet', start_date: (now - 2.days), end_date: (now - 2.days + 2.hours))
past_event.family = @family
past_event.user = @dimitri
past_event.save!

current_event = Event.new(title: 'Faire la présentation', start_date: (now + 5.hour), end_date: (now + 6.hour))
current_event.family = @family
current_event.user = @dimitri
current_event.save!

future_event = Event.new(title: 'Kernel Programming', start_date: (now + 20.hours), end_date: (now + 21.hours))
future_event.family = @family
future_event.user = @dimitri
future_event.save!

# Add some Tasks

@backEnd1 = TaskList.new(title: "Faire les courses")
@backEnd1.family = @family
@backEnd1.author = @dimitri
@backEnd1.save!

@backEnd1.tasks.create!(title: "Acheter du lait", user: @julien, finished: true)
@backEnd1.tasks.create!(title: "Chercher le pain", user: @younes, finished: true)
@backEnd1.tasks.create!(title: "Aller chez le boucher", user: @dimitri, finished: true)

# ---

@backEnd2 = TaskList.new(title: "Presentation EIP", description: "Presentation finale Tek4")
@backEnd2.family = @family
@backEnd2.author = @dimitri
@backEnd2.save!

@backEnd2.tasks.create!(title: "Introduction", user: @julien, finished: true)
@backEnd2.tasks.create!(title: "Présentation features", finished: true)
@backEnd2.tasks.create!(title: "Architecture Technique", user: @dimitri, finished: true)
@backEnd2.tasks.create!(title: "Demo")
@backEnd2.tasks.create!(title: "Difficultés rencontrées", user: @jose)
@backEnd2.tasks.create!(title: "Conclusion")

# ---

@backEnd3 = TaskList.new(title: "Préparation Forum", description: "A définir")
@backEnd3.family = @family
@backEnd3.author = @dimitri
@backEnd3.save!

# Add two invitations

@invitation1 = Invitation.new(email: "francois@gmail.com")
@invitation1.user = @charles
@invitation1.family = @family
@invitation1.save!

# ---

@invitation2 = Invitation.new(email: "don_t_invite_me@gmail.com")
@invitation2.user = @jose
@invitation2.status = "rejected"
@invitation2.family = @family
@invitation2.save!


