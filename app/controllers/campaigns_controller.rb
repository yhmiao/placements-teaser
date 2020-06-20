class CampaignsController < ApplicationController
  before_action :set_campaigns
  before_action :set_campaign, only: :show

  def index
    if params[:search].present?
      sql_query  = query_str(Campaign::SEARCHABLE)
      @campaigns = search_params[:search_text].present? ? @campaigns.where(sql_query) : @campaigns
      @campaigns = @campaigns.page(params[:page]).per(search_params[:per])

      set_search
    else
      @campaigns = @campaigns.page
    end
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
