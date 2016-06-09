class StaticPagesController < ApplicationController
  before_action :check_logged_in, :except => [:home]
  def home
  end

  def help
  end
end
