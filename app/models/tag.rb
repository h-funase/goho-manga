class Tag < ApplicationRecord
  has_many :comic_tags
  has_many :comics, through: :comic_tags

  def save_comics(savecomic_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - savecomic_tags
    new_tags = savecomic_tags - current_tags
  
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end
    new_tags.each do |new_name|
      comic_tag = Tag.find_or_create_by(name:new_name)
      self.tags << comic_tag
    end
  end
end
