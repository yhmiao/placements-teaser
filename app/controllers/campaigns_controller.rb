require 'csv'

class CampaignsController < ApplicationController
  before_action :set_campaigns
  before_action :set_campaign, only: %i[show change_status]

  def index
    col_search = Campaign::SEARCHABLE
    @campaigns = filter_search(@campaigns, col_search)
  end

  def show
    @line_items = @campaign.line_items.page(params[:page]).per(params[:per])

    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"campaign-#{DateTime.current.strftime('%Q')}.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def change_status
    @campaign.send("#{params[:event]}!")
    render :change_status
  rescue AASM::InvalidTransition
    update_alert('status')
    @alert += "\nPlease make sure all line_items have been reviewed first."
    render 'layouts/alert'
  end

  private

  def set_campaigns
    @campaigns = Campaign.includes(:line_items)
  end

  def set_campaign
    @campaign = @campaigns.find(params[:id])
  end
end
