class Comic < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  has_many :comments
  has_many :comic_tags, dependent: :destroy
  has_many :tags, through: :comic_tags
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :episodes, inverse_of: :comic
  accepts_nested_attributes_for :episodes , allow_destroy: true


  # acts_as_taggable_on :labels 
  

  def self.search(search)
    return Comic.all unless search
    search = "%#{search}%"
    Comic.joins(:tags).where(['comics.title LIKE ? OR tags.name LIKE ?',search,search]).uniq
    # Comic.includes(:tags).find_by_sql(["select * from comics where title like ? OR select * from tags where name like ?",search,search])
  end

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
