class HomeController < ApplicationController
  def index
    title = params[:title]
    if title
      @data = Dataverse.search(title)
      @items = @data['data']['items']
    else
      @items = []
    end
  end
end
