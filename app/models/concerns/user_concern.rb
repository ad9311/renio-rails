module UserConcern
  protected

  def set_up_user
    BudgetAccount.create(user_id: id)
  end
end
