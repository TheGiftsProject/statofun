Statofun::Application.routes.draw do

  root :to => "map#index"

  resources :stations, :only => [:show, :index] do
    collection do
      get 'sync'
    end
  end

end
