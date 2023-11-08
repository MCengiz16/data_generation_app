class LogsController < ApplicationController
  def index
    @logs = File.readlines(Rails.root.join('log', 'development.log'))
  end
end