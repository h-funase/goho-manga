class Comic < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  has_many :comments
  has_many :comic_tags, dependent: :destroy
  has_many :tags, through: :comic_tags

  def self.search(search)
    return Comic.all unless search
    Comic.where('text LIKE(?)', "%#{search}%")
  end

  def save_comics(savecomic_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - savecomic_tags
    new_tags = savecomic_tags - current_tags
  
      # Destroy old taggings:
      old_tags.each do |old_name|
        self.tags.delete Tag.find_by(name:old_name)
      end
  
      # Create new taggings:
      new_tags.each do |new_name|
        comic_tag = Tag.find_or_create_by(name:new_name)
        self.tags << comic_tag
      end
    end
end
