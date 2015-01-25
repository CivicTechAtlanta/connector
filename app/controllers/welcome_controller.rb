class WelcomeController < ApplicationController
  layout 'static'

  def index
    @tags = ActsAsTaggableOn::Tag.all.pluck(:name)
  end

  def about
  end

  def conduct
  end

end
