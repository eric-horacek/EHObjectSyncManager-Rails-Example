class RemindersController < ApplicationController

  respond_to :html, :json

  def index
    if params.has_key? :task_id
      @reminders = Reminder.find_all_by_task_id params[:task_id]
    else
      @reminders = Reminder.all
    end
    respond_with @reminders
  end

  def show
    @reminder = Reminder.find(params[:id])
    respond_with @reminder
  end

  def new
    @reminder = Reminder.new
    respond_with @reminder
  end

  def edit
    @reminder = Reminder.find(params[:id])
    respond_with @reminder
  end

  def create
    @reminder = Reminder.new(params[:reminder])
    @reminder.save
    respond_with @reminder
  end

  def update
    @reminder = Reminder.find(params[:id])
    @reminder.update_attributes(params[:reminder])
    respond_with @reminder do |f|
      f.html { redirect_to reminders_path }
    end
  end

  def destroy
    begin
      @reminder = Reminder.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render nothing:true, status: :not_found
      return
    end
    @reminder.destroy
    respond_with @reminder do |f|
      f.html { redirect_to reminders_path }
    end
  end
end
