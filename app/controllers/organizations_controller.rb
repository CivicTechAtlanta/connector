class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all.order(updated_at: :asc)
  end

  def show
  end

end
