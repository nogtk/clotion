class TwitterClientsController < ApplicationController
  def index
    @sales_info = SaleInfo.all
  end
end
