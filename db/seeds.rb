# coding: utf-8
#
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

unless Rails.env.production?

  admin_email = "admin@example.com"
  unless User.find_by_email(admin_email)
    u = User.new(:email => admin_email, :password => 'secret')
    u.account = Account.create
    u.roles = [:admin]
    u.first_name = 'Admin'
    u.last_name = 'Example'
    u.save!
  end

  email = 'user@example.com'
  user = User.find_by_email(email)
  unless user
    account = Account.create!
    user = User.new(:email => email, :password => 'secret')
    user.account = account
    user.first_name = 'User'
    user.last_name = 'Example'
    user.save!
    student = Student.find_or_create_by_first_name_and_last_name_and_grade(
        'John', 'Doe', 'K', :account_id => account.id)
    student.save!
  end

  (1..5).each do |i|
    user_email = "user#{i}@example.com"

    unless User.find_by_email(user_email)
      account = Account.create
      user = User.new(:email => user_email, :password => "secret#{i}")
      user.first_name = Faker::Name.first_name
      user.last_name = Faker::Name.last_name
      user.account = account
      user.save!

      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      student = Student.find_or_create_by_first_name_and_last_name_and_grade(
          first_name, last_name, 'K', :account_id => account.id)
      student.save!
    end
  end

  acc_req = AccountRequest.find_or_create_by_email('marge.simpson@example.com',
      :first_name => 'Marge', :last_name => 'Simpson')
  RequestedStudent.find_or_create_by_first_name_and_last_name(
      'Bart', 'Simpson', :grade => '4', :account_request => acc_req)
  RequestedStudent.find_or_create_by_first_name_and_last_name(
      'Lisa', 'Simpson', :grade => '2', :account_request => acc_req)

end

DayOfWeek::NAMES.each do |day_name|
  DayOfWeek.find_or_create_by_name(day_name)
end

menu_items_by_day = {
  'Monday' => [
    'Hamburger',
    'Cheeseburger',
    'Hot Dog',
    'Grilled Cheese',
    'California Roll',
    'Veggie Roll'
  ],
  'Tuesday' =>  [
    'Indian Veggie',
    'Curry Chicken',
    'Cheese Quesadilla',
    'Beef Quesadilla',
    'Chicken Quesadilla',
  ],
  'Wednesday' => [
    'Chick-fil-A Nuggets',
    'Chick-fil-A Sandwich',
    'Salad'
  ],
  'Thursday' => [
    'Italian Sub',
    'Club Sub',
    'Turkey Sub',
    'Pulled BBQ Sandwich',
    'Cheese Burrito'
  ],
  'Friday' => [
    'Cheese Pizza',
    'Pepperoni Pizza',
    'Salad'
  ]
}

menu_items_by_day.each do |day_name, item_names|
  day = DayOfWeek.find_by_name(day_name)
  item_names.each do |item_name|
    menu_item = MenuItem.find_or_create_by_name(item_name)
    unless day.menu_items.include?(menu_item)
      DailyMenuItem.create!(:day_of_week => day, :menu_item => menu_item)
    end
  end
end

