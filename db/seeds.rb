# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

bookmarks = JSON.parse(File.read("bookmarks_data.json"))
bookmarks.each do |bookmark|
	Bookmark.create!(href: bookmark['href'], tags: bookmark['tags'].split, description: bookmark['description'], extended: bookmark['extended'], meta: bookmark['meta'], hash_value: bookmark['hash'], shared: bookmark['shared'], toread: bookmark['toread'], created_at: bookmark['time'])
end