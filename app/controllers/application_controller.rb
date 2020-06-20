class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(resource)
    line_items_path
  end

  def search_params
    params.require(:search).permit(:search_text, :per)
  end

  def query_str(searchable)
    Array(searchable).map do |col|
      "#{col} LIKE LOWER(#{ActiveRecord::Base.connection.quote("%" + search_params[:search_text] + "%")})"
    end.join(" OR ")
  end

  def set_search
    @search = OpenStruct.new(search_params.to_h)
  end
end
