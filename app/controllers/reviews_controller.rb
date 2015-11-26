class ReviewsController < ApplicationController
  
  before_action :build_review, :only => [:destroy]

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.create(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = 'Review deleted successfully'
    redirect_to '/restaurants'
  end

  def build_review
    @review = Review.find(params[:id])
    unless current_user.id == @review.user_id
      flash[:notice] = "You didn\'t create this review MUTHAFUCKA"
      redirect_to restaurants_path
    end
  end
end