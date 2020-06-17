class CampaignsController < ApplicationController
  def index
    @campaigns = campaigns.page(params[:page]).per(params[:per])
  end

  private

  def campaigns
    Campaign.includes(:line_items)
  end
end
