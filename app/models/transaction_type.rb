# == Schema Information
#
# Table name: transaction_types
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_transaction_types_on_name  (name) UNIQUE
#
class TransactionType < ApplicationRecord
  include TransactionTypeSerializer

  validates :name, length: { minimum: 1, maximum: 25 }

  has_many :incomes, dependent: :destroy
  has_many :expenses, dependent: :destroy
end
