require 'faker'

data = [
  ['Banking', 'banking'],
  ['Clothing', 'clothing'],
  ['Dining out', 'dining_out'],
  ['Entertainment', 'entertainment'],
  ['Food Delivery', 'food_delivery'],
  ['Groceries', 'groceries'],
  ['Home', 'home'],
  ['Insurance/Health', 'insurance'],
  ['Internet/Cellphone', 'internet'],
  ['Online Shopping', 'online_shopping'],
  ['Other', 'other'],
  ['Savings', 'savings'],
  ['Subscriptions', 'subscriptions'],
  ['Transportation', 'transportations'],
  ['Utilities', 'utlities']
]

data.each do |item|
  transaction_type = TransactionType.find_by(uid: item[1])
  TransactionType.create(name: item[0], uid: item[1]) if transaction_type.nil?
end

if Rails.env.development?
  user = User.create(
    email: 'carlos@mail.com',
    password: '123456789',
    password_confirmation: '123456789',
    name: 'Carlos Morales',
    username: 'carlos_morales'
  )

  def year_period(year, user)
    (1..12).each do |month|
      break if Time.zone.now.month == month && Time.zone.now.year == year

      budget = Budget.create(budget_account: user.budget_account, month:, year:)

      Faker::Number.between(from: 1, to: 50).times do
        if Faker::Number.between(from: 1, to: 10).even?
          Income.create(
            budget:,
            description: Faker::Commerce.product_name,
            amount: Faker::Commerce.price,
            transaction_type: TransactionType.all.sample
          )
        else
          Expense.create(
            budget:,
            description: Faker::Commerce.product_name,
            amount: Faker::Commerce.price,
            transaction_type: TransactionType.all.sample
          )
        end
      end
    end
  end

  (2020..2024).each do |year|
    year_period(year, user)
  end
end
