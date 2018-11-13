Rails.application.routes.draw do
  root 'cvs#show'
  get 'cv/edit/:section', to: 'cvs#edit_section', as: 'edit_cv_section'

  resource :cv, except: %i[new edit create destroy] do
    resources :educations
  end
  resolve('Cv') { [:cv] }

  devise_for :users
  get 'home/check'
end
