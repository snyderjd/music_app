class BandsController < ApplicationController
    before_action :require_current_user, only: [:index, :new, :create, :edit, :update, :destroy]

    # Returns index view, list of all the bands
    def index
        @bands = Band.all
        render :index
    end

    # Renders show view that displays one band
    def show
        @band = Band.find(params[:id])
        render :show
    end

    # Renders form to create a new band
    def new
        @band = Band.new
        render :new
    end

    # Creates a new band and saves it to the database
    def create
        @band = Band.create(band_params)

        if @band.save
            redirect_to band_url(@band)
        else
            flash.now[:errors] = @band.errors.full_messages
            render :new
        end

    end

    # Renders form to edit a band
    def edit
        @band = Band.find(params[:id])
        render :edit
    end

    # Updates a band and saves it to the database
    def update
        @band = Band.find(params[:id])
        if @band.update_attributes(band_params)
            redirect_to band_url(@band)
        else
            flash.now[:errors] = @band.errors.full_messages
            render :edit
        end
    end

    # Deletes a band from the database
    def destroy
        @band = Band.find(params[:id])
        @band.destroy
        redirect_to bands_url
    end

    private

    def band_params
        params.require(:band).permit(:name)
    end
end