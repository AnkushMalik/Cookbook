Rails.application.routes.draw do
 resources :comments
 devise_for :users
 resources :recipes do
   member do
     put "like",to: "recipes#upvote"
   end
   put :favorite, on: :member
   resources :comments
 end

 root "recipes#home"
 get 'fav', to: 'recipes#favindex'
 get 'tags/:tag', to: 'recipes#index',as: :tag
end
