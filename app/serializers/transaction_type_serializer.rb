module TransactionTypeSerializer
  include Serializer

  private

  def attributes
    { id:, name:, color: }
  end
end
