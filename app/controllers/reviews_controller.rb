class ReviewsController < ApplicationController
  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @review = Review.new(review_params)
    @review.cocktail = @cocktail
    if @review.save
      redirect_to @cocktail
    else
      @dose = Dose.new
      render 'cocktails/show'
    end
  end

  def like
    @review = Review.find(params[:id])
    @review.update(likes: @review.likes += 1)
    redirect_to cocktail_path(@review.cocktail, anchor: "review-#{@review.id}")
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :user)
  end
end
