class LineItemsController < ApplicationController
  before_action :set_line_items
  before_action :set_line_item, only: %i[show edit update]

  def index
    if params[:search_text].present?
      sql_query   = "#{query_str(LineItem::SEARCHABLE)} OR #{query_str(Campaign::SEARCHABLE)}"
      @line_items = @line_items.left_joins(:campaign).where(sql_query)
    end

    if params[:sort_by].present?
      @line_items = @line_items.order("#{params[:sort_by]} #{params[:order_by] || 'asc'}")
    end

    @line_items = @line_items.page(params[:page]).per(params[:per])
  end

  def show; end

  def edit; end

  def update
    @line_item.update!(line_item_params)

    render :show
  rescue ActiveRecord::StaleObjectError
    @alert = 'Oops, someone has just updated the adjustments.'

    render 'layouts/alert'
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
