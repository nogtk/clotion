class TwitterClientsController < ApplicationController
  def index
    client = TwitterClient.new
    @sales_info = client.sales_info
  end
end
