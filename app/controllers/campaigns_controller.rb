class CampaignsController < ApplicationController
  before_action :set_campaigns
  before_action :set_campaign, only: :show

  def index
    @campaigns = @campaigns.page(params[:page]).per(params[:per])
  end

  def show
    @line_items = @campaign.line_items.page(params[:page]).per(params[:per])
  end

  private

  def set_campaigns
    @campaigns = Campaign.includes(:line_items)
  end

  def set_campaign
    @campaign = @campaigns.find(params[:id])
  end
end
