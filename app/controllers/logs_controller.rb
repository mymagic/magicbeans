class LogsController < ApplicationController
  load_and_authorize_resource
  def index
    @logs = Log.all
  end
end
