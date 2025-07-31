class EntriesController < ApplicationController
  before_action :authenticate_user!

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.new(entry_params)

    if @entry.save
      redirect_to root_path, notice: "Entry was successfully created."
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
