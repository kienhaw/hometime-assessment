Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    post "reservations/update", to: 'reservations#custom_update'
  end
end
