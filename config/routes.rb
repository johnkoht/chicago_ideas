CraigsAdmin::Application.routes.draw do
  
  # the Site
  # ---------------------------------------------------------------------------------------------------------
  root :to => 'application#index'
  # website pages
  match 'team', :to => 'application#team'
  # legalese 
  match 'privacy', :to => 'application#privacy'
  match 'terms', :to => 'application#terms'
  # contact form
  match 'contact', :to => 'application#contact'
  match 'send_contact', :to => 'application#send_contact'
  
  # authentication for the website, uses Devise and Omniauth for facebook and twitter connect
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  match 'account', :to => 'users#index'
  
  resources :users do
    member do
      put :disconnect_facebook
      put :disconnect_twitter
      put :complete_account_update
    end
  end
  
  # the Admin                                                                   (http://www.domain.com/admin)
  # ---------------------------------------------------------------------------------------------------------
  namespace :admin do
  
    root :to => 'admin#index'

    resources :talks do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :topics do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :events do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :sponsors do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :sponsorship_levels do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :partners do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :speakers do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end
  
    # Resources (in alphabetical order)
    # -------------------------------------------------------------------------------------------------------
    resources :days
    
    resources :notes, :only => [] do
      member do
        # notes have attachemts, which are passed through the application because the files are not publically availiable through the Internet
        get :attachment
      end
    end
    
    resources :partners

    resources :speakers

    resources :sponsors
    
    # for the about us page
    resources :staff_bios, :only => [:index, :edit, :update, :destroy]

    # the level of sponsorship
    resources :sponsorship_levels

    # categorization for talks
    resources :topics
  
    resources :users do
      collection do
        # pages
        get :administrators
      end
      member do
        # pages
        get :notes
        get :log_entries
        # methods
        get :undelete
        get :delete
      end
      resources :notes, :only => [:new, :create]
      resources :staff_bios, :only => [:new, :create]
    end
  
    resources :venues
  
  end
  
  # the API                                                                          (http://api.domain.com/)
  # ---------------------------------------------------------------------------------------------------------
  constraints :subdomain => "api" do
    scope :module => "api", :as => "api" do
  
      # the documentation
      root :to => 'documentation#documentation'
  
      resources :speaker, :only => [:list, :show] do
        # search for speakers
        get :search, :on => :collection
        # resources
        resources :talks, :only => [:list, :show]
      end
  
    end
  end
    

end
