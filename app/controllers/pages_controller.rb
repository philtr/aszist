class PagesController < ApplicationController
  def index
    redirect_to(:controller => 'tickets', :action => 'index') and return if user_signed_in?
  end

    def flashitbaby
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'This is a flash notice.' }
    end
  end
end
