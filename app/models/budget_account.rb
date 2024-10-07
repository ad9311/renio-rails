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
  include BudgetAccountSerializer

  belongs_to :user
  has_many :budgets, dependent: :destroy

  def default_transaction_type
    transaction_types.find_by(default: true)
  end
end
