# == Schema Information
#
# Table name: transaction_types
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  uid        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_transaction_types_on_name  (name) UNIQUE
#  index_transaction_types_on_uid   (uid) UNIQUE
#
class TransactionType < ApplicationRecord
  include TransactionTypeSerializer

  validates :name, length: { minimum: 1, maximum: 25 }
  validates :uid, :name, presence: true, uniqueness: true

  has_many :incomes, dependent: :destroy
  has_many :expenses, dependent: :destroy
end
