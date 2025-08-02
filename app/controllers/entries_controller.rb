class EntriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @entries = current_user.entries
    @main_entry = @entries.first
  end

  def show
    @entry = current_user.entries.find(params[:id])
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.new(entry_params)

    if @entry.save
      flash[:notice] = "Entry was successfully created."
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream { }
      end
    else
      flash[:alert] = "There was an error creating the entry. Please try again."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def entry_params
    # params.require(:entry).permit(:name, :url, :username, :password) # Before Rails 8
    params.expect(entry: [:name, :url, :username, :password])
  end
end
