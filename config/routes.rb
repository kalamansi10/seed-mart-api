Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  concern :shop_actions do
    get "/search", to: "shop#search"
    get "/items-properties", to: "shop#items_properties"
    get "/active-banners", to: "shop#active_banners"
    get "/get-item/:item_id", to: "shop#get_item"
  end

  concern :cart_actions do
    get "/get-cart", to: "cart#get_cart"
    get "/get-for-checkout", to: "cart#get_for_checkout"
    post "/add-to-cart", to: "cart#add_to_cart"
    put "/update-carted-amount/:carted_id/:amount", to: "cart#update_carted_amount"
    put "/update-checkout-status/:carted_id/:is_for_checkout", to: "cart#update_checkout_status"
    delete "/remove-from-cart/:carted_id", to: "cart#remove_from_cart"
    get "/is-cart-empty", to: "cart#is_cart_empty?"
  end

  concern :order_actions do
    post "/order", to: "order#process_order"
  end

  concern :user_actions do
    get "/get-shipping-addresses", to: "user#get_shipping_addresses"
    post "/add-shipping-address", to: "user#add_shipping_addresses"
    put "/update-shipping-address", to: "user#update_shipping_address"
    delete "/remove-shipping-address/:shipping_address_id", to: "user#remove_shipping_address"

    get "/get-payment-methods", to: "user#get_payment_methods"
    post "/add-payment-method", to: "user#add_payment_method"
    put "/update-payment-method", to: "user#update_payment_method"
    delete "/remove-payment-method/:payment_method_id", to: "user#remove_payment_method"

    get "/get-orders", to: "user#get_orders"
    get "/get-order/:order_reference", to: "user#get_order"
  end

  namespace :api do
    namespace :v1 do
      concerns :shop_actions
      concerns :cart_actions
      concerns :order_actions
      concerns :user_actions
    end
  end
end
