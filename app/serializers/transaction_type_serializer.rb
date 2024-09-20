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
module TransactionTypeSerializer
  include Serializer

  private

  def attributes(_options = {})
    { id:, name:, uid: }
  end
end
