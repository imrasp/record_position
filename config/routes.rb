Rails.application.routes.draw do
  resources :aircrafts
  resources :missions
  resources :route_gps
  resources :parts
  resources :statuses
  get 'site/index'
  post 'site/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'routes/create_from_post'

  root 'site#index'
  match '/current_pos' => 'site#stream_position', via: :post
  match '/mission_info' => 'site#stream_mission_info', via: :post
  match '/drone_ip' => 'site#stream_ip_add', via: :post
end
