class TracksController < ApplicationController
    before_action :require_current_user

    # GET to /tracks/id - renders the view for a track
    def show
        @track = Track.find(params[:id])
        @album = Album.find(@track.album_id)
        render :show
    end

end