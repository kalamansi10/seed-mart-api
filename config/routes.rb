Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  concern :item_actions do
    get "/item/search", to: "item#search_items"
    get "/item/:item_id", to: "item#get_item"
  end

  concern :cart_actions do
    get "/cart", to: "cart#get_cart"
    get "/cart/for-checkout", to: "cart#get_for_checkout"
    post "/cart", to: "cart#add_to_cart"
    put "/cart/update-amount/:carted_id/:amount", to: "cart#update_carted_amount"
    put "/cart/update-status/:carted_id/:is_for_checkout", to: "cart#update_checkout_status"
    delete "/cart/:carted_id", to: "cart#remove_from_cart"
  end

  concern :order_actions do
    get "/order/list", to: "order#get_order_list"
    get "/order/:reference_id", to: "order#get_order"
    post "/order", to: "order#process_order"
    post "/order/status", to: "order#update_order_status"
  end

  concern :account_actions do
    get "/account/shipping-address/list", to: "account#get_shipping_address_list"
    post "/account/shipping-address", to: "account#add_shipping_address"
    put "/account/shipping-address", to: "account#update_shipping_address"
    delete "/account/shipping-address/:shipping_address_id", to: "account#remove_shipping_address"

    # get "/get-payment-methods", to: "user#get_payment_methods"
    # post "/add-payment-method", to: "user#add_payment_method"
    # put "/update-payment-method", to: "user#update_payment_method"
    # delete "/remove-payment-method/:payment_method_id", to: "user#remove_payment_method"
  end

  concern :review_action do
    get "/review/list/:item_id", to: "review#get_review_list"
    get "/review/:order_id", to: "review#get_review"
    post "/review", to: "review#add_review"
    put "/review/:review_id", to: "review#edit_review"
    delete "/review/:review_id", to: "review#delete_review"
  end

  concern :misc_actions do
    get "/misc/active-banners", to: "misc#get_active_banners"
    get "/misc/item-properties", to: "misc#get_item_properties"
  end

  namespace :api do
    namespace :v1 do
      concerns :item_actions
      concerns :cart_actions
      concerns :order_actions
      concerns :account_actions
      concerns :review_action
      concerns :misc_actions
    end
  end
end
