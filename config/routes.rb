Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Devise
  devise_for :users, controllers: { sessions: 'users/sessions' }

  # Users
  resources :users, only: [] do
    collection do
      get 'me', to: 'users#me'
    end
  end

  # Budget accounts
  resources :budget_accounts, only: :index

  # Budgets
  get 'budgets/current', to: 'budgets#current', as: :current_budget
  resources :budgets, param: :uid, only: %i[index show create] do
    resources :incomes, only: %i[index show create update destroy]
    resources :expenses, only: %i[index show create update destroy]
  end

  # Transaction types
  resources :transaction_types, only: :index
end
