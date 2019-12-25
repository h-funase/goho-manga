class Comic < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  has_many :comments
  has_many :comic_tags, dependent: :destroy
  has_many :tags, through: :comic_tags
  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  def self.search(search)
    return Comic.all unless search

    search = "%#{search}%"


    # categories = [カテゴリーID] 
    # conditions = {} 
    # unless categories.empty?
    #   conditions[:restaurant_categories] = {} 
    #   conditions[:restaurant_categories][:category_id] = categories.map(&:to_i)
    # end
    # @query = Restaurant.left_joins( :restaurant_categories ).where(conditions).uniq 
    
    # > order = Order.includes(:customers).where(customer: { id: 1 })

    

    Comic.joins(:tags).where(['comics.title LIKE ? OR tags.name LIKE ?',search,search])
    # Comic.includes(:tags).find_by_sql(["select * from comics where title like ? OR select * from tags where name like ?",search,search])
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
