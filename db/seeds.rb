# rake db:seed
path = File.join(Rails.root, 'db', 'placements_teaser_data.json')
file = File.open(path)
data = JSON.load(file)

ActiveRecord::Base.transaction do 
  data.each do |datum|
    puts "Creating line_item #{datum['line_item_name']}"

    campaign    = Campaign.find_or_create_by!(id: datum['campaign_id'], name: datum['campaign_name'])
    sel_attrs   = datum.slice(*%w[booked_amount actual_amount adjustments])
    line_params = sel_attrs.merge(name: datum['line_item_name'])

    campaign.line_items.create!(line_params)
  end
end

file.close
