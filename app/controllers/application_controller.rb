class ApplicationController < ActionController::Base

  protect_from_forgery

  private

  include Woodslunch::SecurityFilters

end
