class PagesController < ApplicationController
  def index
    redirect_to tickets_path and return if user_signed_in?
  end
end
