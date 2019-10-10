class TwitterClientsController < ApplicationController
  def index
    client = SalesInformationClient.new
    @sales_info = client.sales_info
  end
end
