# Transaction types
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
