# == Schema Information
#
# Table name: incomes
#
#  id                  :bigint           not null, primary key
#  amount              :decimal(11, 2)   default(0.0), not null
#  description         :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  budget_id           :bigint           not null
#  transaction_type_id :bigint           not null
#
# Indexes
#
#  index_incomes_on_budget_id            (budget_id)
#  index_incomes_on_transaction_type_id  (transaction_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (budget_id => budgets.id)
#  fk_rails_...  (transaction_type_id => transaction_types.id)
#
module IncomeSerializer
  include Serializer

  private

  def attributes
    { id:, description:, amount:, transaction_type: transaction_type.serialized_hash }
  end
end
