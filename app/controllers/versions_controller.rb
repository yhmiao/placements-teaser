class VersionsController < ApplicationController
  before_action :set_versions
  before_action :set_version, only: :show

  def index
    col_search = Version::SEARCHABLE + User::SEARCHABLE
    @versions  = filter_search(@versions, col_search)
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
