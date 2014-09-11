class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all.order(updated_at: :asc)
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      redirect_to(@organization)
    else
      render('new')
    end
  end

private

  def organization_params
    params.require(:organization).permit(:name, :description)
  end
end
