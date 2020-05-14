class TracksController < ApplicationController
    before_action :require_current_user

    # GET to /tracks/id - renders the view for a track
    def show
        @track = Track.find(params[:id])
        @album = Album.find(@track.album_id)
        render :show
    end

    # GET to albums/album_id/tracks/new, renders form for a new track
    def new
        @track = Track.new
        @track.album_id = params[:album_id]
        @albums = Album.all
        render :new
    end

    # POST to /tracks - creates a new track and saves it to the DB
    def create
        @track = Track.new(track_params)
        @albums = Album.all

        if @track.save
            redirect_to album_url(@track.album_id)
        else
            flash.now[:errors] = @track.errors.full_messages
            render :new
        end
    end

    # GET to /tracks/id/edit - renders form to edit a track
    def edit
        @track = Track.find(params[:id])
        @albums = Album.all
        render :edit
    end

    # PATCH to /tracks/id - updates track and saves to the DB
    def update
        @track = Track.find(params[:id])
        @albums = Album.all

        if @track.update_attributes(track_params)
            redirect_to track_url(@track.id)
        else
            flash.now[:errors] = @track.errors.full_messages
            render :edit
        end
    end

    # DELETE to /tracks/id - deletes a track from the database
    def destroy
        track = Track.find(params[:id])
        track.destroy
        redirect_to album_url(track.album_id)
    end

    private

    def track_params
        params.require(:track).permit(:album_id, :title, :order, :is_bonus, :lyrics)
    end

end