Fruitfulminds::Application.routes.draw do
  resources :survey_template
  resources :users
  resources :sessions, :only => [:create, :destroy, :new]
  resources :reports
  resources :presurveys
  resources :postsurveys
  resources :foodjournals, :to => "food_journals"
  resources :schools
  resources :colleges
  resources :admin
  resources :historical

  # The priority is based upon order of creation:
  # first created -> highest priority.

  match "login"  => "sessions#new", :as => "login"
  match "logout" => "sessions#destroy", :as => "logout"
  match "signup" => "users#new", :as => "signup"
  match "services" => "users#tos", :as => "tos"
  match "portal" => "home#portal", :as => "portal", :via => :get
  match "pending_users" => "users#pending_users", :as => "pending_users", :via => :get
  match "update_pending_users" => "users#update_pending_users", :as => "update_pending_users", :via => :post
  match "reports/generate_pdf" => "reports#generate_pdf", :via => :post
  match "tos" => "users#tos", :as => "tos"
  match "remove_course" => "users#remove_course", :as => "remove_course"
  match "add_course" => "users#add_course", :as => "add_course"
  match "inactive_courses" => "home#inactive_courses", :as => "inactive_courses"
  match "all_users" => "users#all_users", :as => "all_users", :via => :get
  match "update_all_users" => "users#update_all_users", :as => "update_all_users", :via => :post
  match "deactivate_user" => "users#deactivate_user", :as => "deactivate_user"
  match "activate_user" => "users#activate_user", :as => "activate_user"
  match "all_efficacies" => "reports#all_efficacies", :as => "all_efficacies", :via => :get
  root :to => redirect('/portal')

end
