Statofun::Application.routes.draw do

  root :to => "map#index"

  resources :stations, :only => [] do
    collection do
      get 'sync'
    end
  end

end
