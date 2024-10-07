module BudgetConcern
  module ScopesMethods
    def find_current_budget(budget_account, incomes: false, expenses: false)
      uid = get_uid(budget_account)

      return includes(:incomes).where(uid:) if incomes

      return includes(:expenses).where(uid:) if expenses

      return includes(%i[incomes expenses]).where(uid:) if incomes && expenses

      where(uid:)
    end

    def by_uid(uid, incomes: false, expenses: false)
      return includes(:incomes).where(uid:) if incomes

      return includes(:expenses).where(uid:) if expenses

      return includes(%i[incomes expenses]).where(uid:) if incomes && expenses

      where(uid:)
    end

    private

    def get_uid(budget_account)
      current_date = Time.zone.now
      year = current_date.year
      month = current_date.month
      "#{budget_account.id}-#{year}-#{month.to_s.rjust(2, '0')}"
    end
  end
end
