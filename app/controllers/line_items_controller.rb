class LineItemsController < ApplicationController
  before_action :set_line_items
  before_action :set_line_item, only: %i[edit update]

  def index
    @line_items = @line_items.page(params[:page]).per(params[:per])
  end

  def edit; end

  def update
    @line_item.update!(line_item_params)

    render :show
  end

  private

  def set_line_items
    @line_items = LineItem.includes(:campaign)
  end

  def set_line_item
    @line_item = @line_items.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:adjustments, :lock_version)
  end
end
