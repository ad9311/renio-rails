# == Schema Information
#
# Table name: transaction_types
#
#  id                :bigint           not null, primary key
#  color             :string           not null
#  default           :boolean          default(FALSE), not null
#  name              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  budget_account_id :bigint           not null
#
# Indexes
#
#  index_transaction_types_on_budget_account_id  (budget_account_id)
#
# Foreign Keys
#
#  fk_rails_...  (budget_account_id => budget_accounts.id)
#
module TransactionTypeSerializer
  include Serializer

  private

  def attributes(_options = {})
    { id:, name:, color: }
  end
end
