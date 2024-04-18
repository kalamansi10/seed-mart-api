class Api::V1::ReviewController < ApplicationController
    # GET /api/v1/review/list/:item_id
    def getReviewList
      item = Item.find(params[:item_id])
      render json: item.reviews.order(created_at: :desc)
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

    def review_params
      params.require(:review).permit(
        :item_id,
        :order_id,
        :rating,
        :comment
      )
    end

end
