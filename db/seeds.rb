# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

file_types = FileType.create([{title: "uvis"}, {title: "ephem"}])

bodies = Body.create([
						{name: "Rhea"}
						{name: "Mimas"}
						{name: "Iapetus"}
						{name: "Enceladus"}
						{name: "Titan"}
						{name: "Sun"}
						{name: "Dione"}
						{name: "Cassini"}
					])