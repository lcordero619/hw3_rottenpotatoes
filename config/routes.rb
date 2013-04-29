Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  post '/movies/director_search'
  root :to => redirect('/movies')

end
