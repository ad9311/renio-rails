module UserConcern
  protected

  def set_up_user
    budget_account = BudgetAccount.create(user_id: id)
    TransactionType.create(budget_account:)
  end
end
