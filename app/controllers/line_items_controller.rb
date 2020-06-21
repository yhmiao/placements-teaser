class LineItemsController < ApplicationController
  before_action :set_line_items
  before_action :set_line_item, only: %i[show edit update change_status]

  def index
    col_search  = LineItem::SEARCHABLE + LineItem::SEARCHABLE
    @line_items = filter_search(@line_items, col_search)
  end

  def show; end

  def edit; end

  def update
    @line_item.update!(line_item_params)
    render :show
  rescue ActiveRecord::StaleObjectError => e
    update_alert('adjustments')
    render 'layouts/alert'
  end

  def change_status
    @line_item.send("#{params[:event]}!")
    render :change_status
  rescue AASM::InvalidTransition
    update_alert('status')
    render 'layouts/alert'
  end

  private

  def set_line_items
    @line_items = LineItem.includes(:campaign).left_joins(:campaign)
  end

  def set_line_item
    @line_item = @line_items.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:adjustments, :lock_version)
  end
end
