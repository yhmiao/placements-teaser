class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit

  protected

  def after_sign_in_path_for(resource)
    line_items_path
  end

  def filter_search(records, col_search)
    records = search_text(records, col_search)
    records = sort_by(records)
    count   = params[:per] == 'All' ? records.count : params[:per]

    records.page(params[:page]).per(count)
  end

  def query_str(searchable)
    Array(searchable).map do |col|
      "#{col} LIKE LOWER(#{ActiveRecord::Base.connection.quote("%" + params[:search_text] + "%")})"
    end.join(" OR ")
  end

  def update_alert(column)
    @alert = "Oops, update #{column} has failed."
    @alert += "\nRefresh page to see if #{column} has already been updated."
  end

  def search_text(records, col_search)
    records = records.where(query_str(col_search)) if params[:search_text].present?

    records
  end

  def sort_by(records)
    records = records.order("#{params[:sort_by]} #{params[:order_by] || 'asc'}") if params[:sort_by].present?

    records
  end
end
