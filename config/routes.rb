Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  concern :shop_queries do
    get "/most-recent(/:offset)", to: "shop#most_recent"
    get "/search", to: "shop#search"
    get "/items-properties", to: "shop#items_properties"
    get "/active-banners", to: "shop#active_banners"
    get "/get-item/:item_id", to: "shop#get_item"
  end

  namespace :api do
    namespace :v1 do
      concerns :shop_queries
    end
  end
end
