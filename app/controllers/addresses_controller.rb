class AddressesController < ApplicationController
  before_action :authenticate_user!

  def update
    @address = Address.find_by!(uid: params[:id])
    @address.update!(address_params)
    render json: {
      page_url: @address.page_url,
      page_path: @address.page_path,
    }
  end

  private
    def address_params
      params.require(:address).permit(:page_id)
    end
end
