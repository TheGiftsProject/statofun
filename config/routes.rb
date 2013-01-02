Statofun::Application.routes.draw do

  root :to => "map#index"

  resources :stations, :only => [:show, :index] do
  end

end
