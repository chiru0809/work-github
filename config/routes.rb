Rails.application.routes.draw do

  root to: "public/homes#top", as: 'top'
  get '/about', to: 'public/homes#about', as: 'about'
  get 'orders/thanks', to: 'public/orders#thanks', as: 'thanks'
  

  scope module: :public do
    resources :items, only: [:index, :show]
    resources :orders, only: [:index, :new, :create, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    
    get '/customers', to: 'customers#show', as: 'my_page'
    get '/customers/information/edit', to: 'customers#edit', as: 'my_page_edit'
    patch '/customers', to: 'customers#update', as: 'my_page_update'
    get '/customers/confirm', to: 'customers#confirm', as: 'confirm'
    patch '/customers/cancel', to: 'customers#cancel', as: 'cancel'
    
    delete '/cart_items/destroy_all', to: 'cart_items#destroy_all', as: 'destroy_all'
  end
  namespace :admin do
    get '/', to: 'homes#top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit]
    resources :orders, only: [:show]
    resources :order_details, only: [:update]
  end
  
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
