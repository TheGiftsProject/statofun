Statofun::Application.routes.draw do

  root :to => "map#index"

  resources :stations, :only => [:show] do
  end

end
