class TwitterClientsController < ApplicationController
  def index
    client = TwitterClient.new
    list_users = client.timeline_members
    @sales_info = client.sales_info(list_users)
  end
end
