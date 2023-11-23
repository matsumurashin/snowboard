class ApplicationController < ActionController::Base
  before_action :authenticate_customer!, except: [:top, :about]
  before_action :authenticate_admin!, except: [:top, :about]
end
