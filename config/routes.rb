# frozen_string_literal: true

Spina::Engine.routes.draw do
  get 'inbound_email/index'
  get 'inbound_email/edit'
  get 'inbound_email/show'
  get 'inbound_email/update'
  get 'inbound_email/destroy'
  namespace :admin, path: Spina.config.backend_path do
    namespace :mail do
      root to: 'inbound_emails#index'
      resources :inbound_emails, except: %i[new create]
      resources :outbound_emails
      resources :emails, only: :show
      resources :mailboxes
    end
  end
end
