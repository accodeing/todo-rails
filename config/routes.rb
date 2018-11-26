Rails.application.routes.draw do
  resources :todo_lists
  
  root "todo_lists#index"
end
