class FavouritesController < ApplicationController
  before_action :authenticate_user
  before_action :set_post

  def create
    favourite = Favourite.new(post: @post, user: current_user)
    if favourite.save
      respond_to do |wants|
        wants.html { redirect_to @post, notice: "Favourited!" }
        wants.js { render :favourite_success }
      end
      
    else
      respond_to do |wants|
        wants.html { redirect_to @post, alert: "Not favourited!" }
        wants.js { render :favourite_failure }
      end
      
    end
  end

  def destroy
    favourite = current_user.favourites.find params[:id]
    favourite.destroy
    respond_to do |wants|
      wants.html { redirect_to @post, notice: "Un-favourited" }
      wants.js { render :favourite_success }
    end
    

  end

  def index
    @favourites = current_user.favourited_posts
    # @favourites = Favourite.where("user_id = ?", current_user)    
    # binding.remote_pry
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
