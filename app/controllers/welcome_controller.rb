class WelcomeController < ApplicationController
  before_action :authenticate_user!, except: %i(index)

  def index
    redirect_to :dashboard if user_signed_in? && !Rails.env.development?
  end

  def dashboard
    @notes = client.managed_notes
    @addresses = @notes.map do |note|
      Address.find_or_create_by_note(note, current_user)
    end
  end

  def pages
    @pages = client.pages(params[:team], params[:note], 'all')
    render json: @pages
  end
end
