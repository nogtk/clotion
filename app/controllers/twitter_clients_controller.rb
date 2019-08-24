class TwitterClientsController < ApplicationController
  def index
    client = TwitterClient.new
    @list_users = client.timeline_members
  end
end
