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

  scope :api do
    # Budgets
    resources :budgets, param: :uid, only: %i[index show create]
    get 'current', to: 'budgets#current', as: :current_budget
  end
end
