# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

surveys = [
            {:school_id => 2, :s1 => 7, :s2 => 2, :s3 => 2, :s4 => 2, :s5 => 2, :s6 => 6, :s7 => 4, :s8 => 6, :s9 => 8, :s10 => 5, :e1 => 6, :e2 => 9, :e3 => 3, :e4 => 1, :e5 => 6, :e6 => 5}
            {:school_id => 9, :s1 => 3, :s2 => 2, :s3 => 4, :s4 => 2, :s5 => 7, :s6 => 6, :s7 => 4, :s8 => 8, :s9 => 8, :s10 => 5, :e1 => 8, :e2 => 9, :e3 => 7, :e4 => 1, :e5 => 5, :e6 => 2}
          ]

surveys.each do |survey|
  Survey.create!(survey)
end
