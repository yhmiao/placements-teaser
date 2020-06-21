class Version < PaperTrail::Version
  SEARCHABLE = %w[item_type item_id event versions.created_at].freeze

  serialize :object, Hash

  belongs_to :user, foreign_key: :whodunnit

  def get_item
    item_type.constantize.find_by_id(item_id)
  end
end
