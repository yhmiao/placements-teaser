class VersionsController < ApplicationController
  before_action :set_versions
  before_action :set_version, only: :show

  def index
    if params[:search_text].present?
      sql_query = "#{query_str(Version::SEARCHABLE)} OR #{query_str(User::SEARCHABLE)}"
      @versions = @versions.where(sql_query)
    end

    if params[:sort_by].present?
      @versions = @versions.order("#{params[:sort_by]} #{params[:order_by] || 'asc'}")
    end

    @versions = @versions.page(params[:page]).per(params[:per])
  end

  def show
    @item = @version.get_item
  end

  private

  def set_versions
    @versions = Version.includes(:user).left_joins(:user)
  end

  def set_version
    @version = @versions.find(params[:id])
  end
end
