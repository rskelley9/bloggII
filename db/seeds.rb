
#three authenticated users (authors)

User.create(email: "RKelley@anonymousblog.com", first_name: "RKelley", password: "pass")
User.create(email: "Carl@anonymousblog.com", first_name: "Carl", password: "pass")
User.create(email: "Lisa@anonymousblog.com", first_name: "Lisa", password: "pass")

#posts
tag_id = (1..5).to_a
user_id = (1..3).to_a

10.times do 
	Tag.create(name: Faker::Lorem.words(num = 1))
end


20.times do
	Post.create(
		title: Faker::Lorem.words(num = 1),
		content: Faker::Lorem.sentences(sentence_count = 3),
		user_id: user_id.sample,
		tag_id: tag_id.sample
		)
	
end

