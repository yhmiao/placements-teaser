class LineItemsController < ApplicationController
  def index
    @line_items = LineItem.all
  end
end
