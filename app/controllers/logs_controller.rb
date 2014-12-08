class LogsController < ApplicationController

  def index
    @logs = Log.all

    respond_to do |format|
      format.html { render :layout => !request.xhr? }
      # other formats
    end
  end
end
