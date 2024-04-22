class Api::V1::ReviewController < ApplicationController
    # GET /api/v1/review/list/:item_id
    def getReviewList
      reviews = Item.find(params[:item_id]).reviews.order(created_at: :desc)
      reviews = addReviewer(reviews)
      render json: reviews
    end

    # POST /api/v1/review
    def addReview
      current_user.reviews.create(review_params)
    end
    # PUT /api/v1/review
    def editReview
      current_user.reviews.update(review_params)
    end
    # DELETE /api/v1/review
    def deleteReview
      Review.find(params[:review_id]).destroy
    end

    private

    def addReviewer(reviews)
      reviews.map do |review|
        review_hash = review.attributes
        return review_hash if review.is_anonymous?
        review_hash.merge({ reviewer: review.user.name })
      end
    end

    def review_params
      params.require(:review).permit(
        :item_id,
        :order_id,
        :rating,
        :comment
      )
    end

end
