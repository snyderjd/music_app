class NotesController < ApplicationController
    before_action :require_current_user

    # POST to /notes - creates a new note and saves it to the DB
    def create
        @note = Note.new(note_params)
        @note.user_id = current_user.id

        if @note.save
            redirect_to track_url(@note.track_id)
        else
            flash.now[:errors] = @note.errors.full_messages
            redirect_to track_url(@note.track_id)   
        end
    end

    # DELETE to /notes/id - deletes a note
    def destroy
        note = current_user.notes.find(params[:id])
        note.destroy
        redirect_to track_url(note.track_id)
    end

    private

    def note_params
        params.require(:note).permit(:user_id, :track_id, :content)
    end

    # def track_params
    #     params.require(:track).permit(:album_id, :title, :order, :is_bonus, :lyrics)
    # end
    
end