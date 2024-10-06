module BudgetConcern
  module ScopesMethods
    def current_budget(budget_account, incomes: false, expenses: false)
      uid = get_uid(budget_account)

      return includes(:incomes).find_by(uid:) if incomes

      return includes(:expenses).find_by(uid:) if expenses

      return includes(%i[incomes expenses]).find_by(uid:) if incomes && expenses

      find_by(uid:)
    end

    def by_uid(uid, incomes: false, expenses: false)
      return includes(:incomes).find_by(uid:) if incomes

      return includes(:expenses).find_by(uid:) if expenses

      return includes(%i[incomes expenses]).find_by(uid:) if incomes && expenses

      find_by(uid:)
    end

    private

    def get_uid(budget_account)
      current_date = Time.zone.now
      year = current_date.year
      month = current_date.month
      "#{budget_account.id}_#{year}_#{month.to_s.rjust(2, '0')}"
    end
  end
end
