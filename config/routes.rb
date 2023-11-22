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

  concern :cart_actions do
    get "/get-cart", to: "cart#get_cart"
    post "/add-to-cart", to: "cart#add_to_cart"
    post "/update-cart", to: "cart#update_cart"
    delete "/remove-from-cart/:carted_id", to: "cart#remove_from_cart"
  end

  namespace :api do
    namespace :v1 do
      concerns :shop_queries
      concerns :cart_actions
    end
  end
end
