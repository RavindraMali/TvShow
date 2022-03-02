class ShowsController < ApplicationController
    before_action :authenticate_user!, only: :show
    before_action :get_show, only: [:add_to_favorites, :remove_from_favorites]
    def index
        # @shows = Show.all
        if params[:search]
            flash[:success] = "Search results"
            @shows = Show.search(params[:search].strip).order("created_at DESC").paginate(page: params[:page])
        else
            @shows = Show.all.order("created_at DESC").paginate(page: params[:page])
        end
    end

    def show
        @show = Show.find(params[:id])
        ShowNotificationJob.perform_async(@show.name)
    end

    def add_to_favorites
        if current_user.favorite(@show)
            flash[:success] = "Marked as favorite"
        else
            flash[:alert] = "Can not mark favorite. please try again later."
        end
        redirect_back fallback_location: shows_path

    end

    def remove_from_favorites
        if current_user.unfavorite(@show)
            flash[:success] = "Removed from your favorites"
        else
            flash[:alert] = "Can not removed from favorites. please try again later."
        end
        redirect_back fallback_location: shows_path
    end

    def favorites_index
        @shows = current_user.all_favorited
    end

    private
    def get_show
        @show = Show.find(params[:id])
    end
end
