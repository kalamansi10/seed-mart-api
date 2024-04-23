class Api::V1::ReviewController < ApplicationController
    # GET /api/v1/review/list/:item_id
    def get_review_list
      reviews = Item.find(params[:item_id]).reviews.order(created_at: :desc)
      reviews = add_reviewer(reviews)
      render json: reviews
    end

    # GET /api/v1/review/:order_id
    def get_review
      review = Review.find_by(order_id: params[:order_id])
      render json: review
    end

    # POST /api/v1/review
    def add_review
      current_user.reviews.create(review_params)
    end
    # PUT /api/v1/review
    def edit_review
      review = Review.find(params[:review_id]).update(review_params)
    end
    # DELETE /api/v1/review
    def delete_review
      Review.find(params[:review_id]).destroy
    end

    private

    def add_reviewer(reviews)
      reviews.map do |review|
        if review.is_anonymous
          { **review.attributes, reviewer: "Anonymous" }
        else
          { **review.attributes, reviewer: review.user.name }
        end
      end
    end

    def review_params
      params.require(:review).permit(
        :item_id,
        :order_id,
        :rating,
        :comment,
        :is_anonymous
      )
    end

end
