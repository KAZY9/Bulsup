Rails.application.routes.draw do
  root 'mainpages#top'
  get '/top', to: 'mainpages#top'
  post '/calculate', to: 'mainpages#calculate'
  get '/results', to: 'mainpages#results'
  post '/suggest_meal', to: 'mainpages#suggest_meal'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }
  devise_scope :user do
    post '/guest_sign_in', to: 'users/sessions#guest_sign_in'
    get '/sign_up', to: 'users/registrations#new'
    get '/sign_up/complete', to: 'users/registrations#complete'
    post '/sign_up/complete', to: 'users/registrations#create'
    get '/forgot', to: 'users/passwords#new'
    get '/forgot/complete', to: 'users/passwords#complete'
    get '/mypage/edit', to: 'users/registrations#edit'
    get 'check_login_status', to: 'users/sessions#check_login_status'
  end
  get '*path', to: redirect('/')
end
