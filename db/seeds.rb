# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seed my admin account

admin = User.new({
  firstname: 'Jeshy',
  lastname: 'Yates',
  email: 'jeshy.yates@gmail.com',
  password: 'password',
  is_admin: true,
})

admin.skip_confirmation!
admin.save!

title = <<DELIMITER
PSA about the day that Matthew Hurt's life changed forever!
DELIMITER

content = <<DELIMITER
<h1><img style="display: block; margin-left: auto; margin-right: auto;" src="https://www.simplegreensmoothies.com/wp-content/uploads/2013/01/Beginners-Luck-Green-Smoothie.jpg" alt="Green Smoothie" width="600" height="480" /></h1>
<h1 style="text-align: center;">Hello World!</h1>
<h2 style="text-align: center;">You need to know that on this day, Wednesday, December 13, 2017, Matthew Hurt drank his first green smoothie!</h2>
<h3 style="text-align: center;"><strong>And survived.</strong></h3>
<h3 style="text-align: center;"><strong>And didn't mind it.</strong></h3>
<h3 style="text-align: center;">That is all.</h3>
<h3 style="text-align: center;">As you were.</h3>
DELIMITER

Article.create({
  title: title,
  content: content,
  user_id: admin.id,
  })

30.times do
  firstname = Faker::Name.first_name
  lastname = Faker::Name.last_name
  email = Faker::Internet.email(firstname + lastname)
  password = "password"
  user = User.new({
    firstname: firstname,
    lastname: lastname,
    email: email,
    password: password,
  })

  user.skip_confirmation!
  user.save!

  5.times do
    Article.create({
      title: Faker::Boolean.boolean,
      content: Faker::ChuckNorris.fact,
      user_id: user.id
      })

    list = List.create({
        name: Faker::Food.dish,
        user_id: user.id,
      })

    5.times do
      recipe = rand(2) == 0 ? Faker::Food.ingredient : Faker::Food.spice
      Item.create({
        completed: false,
        list_id: list.id,
        description: "#{Faker::Food.measurement} #{recipe} ",
      })
    end
  end

end
