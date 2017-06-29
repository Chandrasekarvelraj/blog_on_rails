class ErrorsController < ApplicationController
  def error404
    render layout: false, status: :not_found
  end
end