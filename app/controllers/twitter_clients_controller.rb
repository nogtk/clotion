class TwitterClientsController < ApplicationController
  def index
    @sales_info = SaleInfo.all.includes(:shop)
  end
end
