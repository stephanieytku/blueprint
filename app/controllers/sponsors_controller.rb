class SponsorsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :confirm_user
  before_filter :set_sponsorship_types
  
  def set_sponsorship_types
    @sponsorship_types = ['Gold Sponsor', 'Silver Sponsor', 'Partner']
  end

  def index
    @sponsors = Sponsor.order('type')
  end

  def new
    @sponsor = Sponsor.new
  end

  def edit
    @sponsor = Sponsor.find(params[:id])
  end

  def create
    @sponsor = Sponsor.new(params[:sponsor])
    if @sponsor.save
      redirect_to edit_sponsors_path, notice: 'New sponsor was created!'
    else
      render action: "new"
    end
  end

  def update
    @sponsor = Sponsor.find(params[:id])
    if @sponsor.update_attributes(params[:sponsor])
      redirect_to edit_sponsors_path, notice: "Sponsor was updated."
    else
      render action: "edit"
    end
  end

  def destroy
    @sponsor = Sponsor.find(params[:id])
    @sponsor.image = nil
    @sponsor.destroy

    redirect_to edit_sponsors_path
  end
end