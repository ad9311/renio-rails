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

  def default_transaction_type
    transaction_types.find_by(default: true)
  end

  # def current_budget(income: false, expenses: false)
  #   current_date = Time.zone.now
  #   uid = "#{user.id}_#{current_date.year}_#{current_date.month}"

  #   return Budget.eager_load(:incomes).find_by(uid:) if income

  #   return Budget.eager_load(:expenses).find_by(uid:) if expenses

  #   return Budget.eager_load(%i[incomes expenses]).find_by(uid:) if income && expenses

  #   Budget.find_by(uid:)
  # end
end
