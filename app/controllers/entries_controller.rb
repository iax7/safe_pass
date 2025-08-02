class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry, only: %i[show destroy]

  def index
    @entries = current_user.entries
    @main_entry = @entries.first
  end

  def show
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.new(entry_params)

    if @entry.save
      flash.now[:notice] = "<strong>#{@entry.name}</strong> was successfully created.".html_safe
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream { }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @entry.destroy
    @default = current_user.entries.first
    flash.now[:notice] = "<strong>#{@entry.name}</strong> was successfully deleted.".html_safe
    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream { }
    end
  end

  private

  def entry_params
    # params.require(:entry).permit(:name, :url, :username, :password) # Before Rails 8
    params.expect(entry: [:name, :url, :username, :password])
  end

  def set_entry
    @entry = current_user.entries.find(params[:id])
  end
end
