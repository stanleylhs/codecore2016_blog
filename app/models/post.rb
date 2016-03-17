# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  name        :string
#  title       :string
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  user_id     :integer
#

class Post < ActiveRecord::Base
  # attr_accessor :content, :name, :title

  has_many :post_attachments, dependent: :destroy
  accepts_nested_attributes_for :post_attachments

  paginates_per 50
  max_paginates_per 100
 
  validates :title, presence: true,
                    uniqueness: true, 
                    length: { :minimum => 7 }
  validates :content, presence: true
 
  has_many :comments, :dependent => :destroy
  has_many :favourites, dependent: :destroy

  belongs_to :category
  belongs_to :user

  delegate :full_name, to: :user, prefix: true, allow_nil: :true

  # 1 query not N+1
  scope :with_new_comments, -> { joins(:comments).includes(:comments).where('comments.created_at >= ?', 1.day.ago) }

  def favourite_for(user)
    favourites.find_by_user_id user
  end
  
  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("title ILIKE :search OR content ILIKE :search ", search: "%#{query}%") 
  end

  def category_name
    category.name if category
  end

  def body_snippet
    content.length > 100 ? content[0..99] + '...' : content
  end
end
