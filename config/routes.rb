Rails.application.routes.draw do
  # get 'events/attend_event'
  # get 'events/unattend_event'
  get 'home/index'
  resources :events do
    get :attend_event, on: :member
    get :unattend_event, on: :member
  end
  devise_for :users
  root to: "events#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
