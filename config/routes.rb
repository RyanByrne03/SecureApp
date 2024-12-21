Rails.application.routes.draw do
  root 'todos#index'

  resources :todos do
    member do
      patch :mark_as_completed
    end
  end

  get 'admin', to: 'admin#index'
  delete 'admin/todo/:id', to: 'admin#destroy', as: 'admin_destroy_todo'
end
