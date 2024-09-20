# Transaction types
names = [
  'Banking',
  'Clothing',
  'Dining out',
  'Entertainment',
  'Food Delivery',
  'Groceries',
  'Home',
  'Insurance/Health',
  'Internet/Cellphone',
  'Online Shopping',
  'Other',
  'Savings',
  'Subscriptions',
  'Transportation',
  'Utilities'
]

names.each do |name|
  transaction_type = TransactionType.find_by(name:)
  TransactionType.create(name:) if transaction_type.nil?
end
