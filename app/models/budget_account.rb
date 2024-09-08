# == Schema Information
#
# Table name: budget_accounts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_budget_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class BudgetAccount < ApplicationRecord
  belongs_to :user
  has_many :budgets, dependent: :destroy
  has_many :transaction_types, dependent: :destroy
end
