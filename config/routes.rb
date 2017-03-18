Rails.application.routes.draw do
	
  get 'activities/index'

  devise_for :users

  resources :clearance_batches do #, only: [:index, :create, :destroy]
  	resources :items          
  end
  
  resources :activities

  root "clearance_batches#index" 

  match '/mybatches', to: 'clearance_batches#mybatches', via: :get  
  match '/buy/:id', to: 'clearance_batches#buybatch', via: :get  
  match '/undobatch/:id', to: 'clearance_batches#undobatch', via: :get  

  match '/staffperformance', to: 'pages#staffperformance', via: :get  

  #match '/usecsv', to: 'pages#usecsv', via: :get

  resources :pages, only: [:index, :create, :staffperformance]
  
  

end
