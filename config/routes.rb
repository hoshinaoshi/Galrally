Master::Application.routes.draw do
  root to: 'top#index'
  resources :top
  resources :review
  get 'tags/add' => 'tags#add'
  resources :tags
  get 'blogs/add' => 'blogs#add'
  resources :blogs

  get "*other", :to => 'application#render_404'
end
