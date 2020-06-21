class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(resource)
    line_items_path
  end

  def query_str(searchable)
    Array(searchable).map do |col|
      "#{col} LIKE LOWER(#{ActiveRecord::Base.connection.quote("%" + params[:search_text] + "%")})"
    end.join(" OR ")
  end

  def update_alert(column)
    @alert = "Oops, #{column} has failed."
    @alert += " Refresh page to see if #{column} has already been updated."
  end
end
