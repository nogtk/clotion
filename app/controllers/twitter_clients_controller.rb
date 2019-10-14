class TwitterClientsController < ApplicationController
  def index
    client = SalesInformationClient.new
    @sales_info = client.sales_info_for_view
  end
end
