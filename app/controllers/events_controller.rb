class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :attend_event, :unattend_event]
  before_action :require_organizer, only: [:edit, :update, :destroy]
  before_action :require_logged_in_user, only: [:attend_event, :unattend_event]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user = current_user
      if @event.save
        redirect_to @event, notice: 'Event was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event.user = current_user
      if @event.update(event_params)
        redirect_to @event, notice: 'Event was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  def attend_event
    redirect_to events_url, notice: 'You cannot attend a past event' if @event.event_schedule <= Date.today
    attendance = Attendance.new
    attendance.user_id = current_user.id
    attendance.event = @event

    if attendance.save
      redirect_to events_path, notice: 'You are now attending the event.'
    else
      redirect_to events_path, notice: 'There was an issue creating your attendance'
    end
  end

  def unattend_event
    redirect_to events_url, notice: 'You cannot unattend a past event' if @event.event_schedule <= Date.today

    attendance = Attendance.find_by(user_id: current_user.id, event_id: @event.id)

    if attendance.destroy
      redirect_to events_url, notice: 'You have un-attended from the event.'
    else
      redirect_to events_url, notice: 'There was an issue updating your attendance'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :event_schedule, :fee)
    end

    def require_owner
      redirect_to events_url, notice: 'Only the owner of the event can perform this action' unless current_user.present? && @event.user.id == current_user.id
    end
end
