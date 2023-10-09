Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'mainpages#top'
  get '/top', to: 'mainpages#top'
  post '/calculate', to: 'mainpages#calculate'
  get '/results', to: 'mainpages#results'
  post '/suggest_meal', to: 'mainpages#suggest_meal'
end
