Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  concern :shop_actions do
    get "/most-recent(/:offset)", to: "shop#most_recent"
    get "/search", to: "shop#search"
    get "/items-properties", to: "shop#items_properties"
    get "/active-banners", to: "shop#active_banners"
    get "/get-item/:item_id", to: "shop#get_item"
  end

  concern :cart_actions do
    get "/get-cart", to: "cart#get_cart"
    get "/get-for-checkout", to: "cart#get_for_checkout"
    post "/add-to-cart", to: "cart#add_to_cart"
    post "/update-cart", to: "cart#update_cart"
    delete "/remove-from-cart/:carted_id", to: "cart#remove_from_cart"
  end

  concern :user_actions do
    get "/get-shipping-addresses", to: "user#get_shipping_addresses"
    post "/add-shipping-address", to: "user#add_shipping_addresses"
    post "/update-shipping-address", to: "user#update_shipping_address"
    delete "/remove-shipping-address/:shipping_address_id", to: "user#remove_shipping_address"

    get "/get-payment-methods", to: "user#get_payment_methods"
    post "/add-payment-method", to: "user#add_payment_method"
    post "/update-payment-method", to: "user#update_payment_method"
    delete "/remove-payment-method/:payment_method_id", to: "user#remove_payment_method"

    get "/get-orders", to: "user#get_orders"
    get "/get-order/:order_reference", to: "user#get_order"
  end

  namespace :api do
    namespace :v1 do
      concerns :shop_actions
      concerns :cart_actions
      concerns :user_actions
    end
  end
end
