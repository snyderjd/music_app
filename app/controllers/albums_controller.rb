class AlbumsController < ApplicationController
    before_action :require_current_user

    # GET /albums/id
    # Renders the view for an album
    def show
        @album = Album.find(params[:id])
        render :show
    end
    
    # Renders form for a new album
    def new
        @album = Album.new
        @bands = Band.all
        render :new
    end

    # Creates a new album and saves it to the database
    def create
        @album = Album.new(album_params)
        @bands = Band.all

        if @album.save
            redirect_to band_url(@album.band_id)
        else
            flash.now[:errors] = @album.errors.full_messages
            render :new
        end

    end

    private

    def album_params
        params.require(:album).permit(:title, :year, :is_live, :band_id)
    end

end