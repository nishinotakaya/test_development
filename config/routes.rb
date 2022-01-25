Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
}

devise_scope :user do
  root :to => "users/sessions#new"
  put 'confirmation', to: 'users/confirmations#show', as: :back_confirmation
end

devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
  get '/users/dash_bord'
  get '/users/login_before'
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
