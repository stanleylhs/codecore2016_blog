# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  commenter  :string
#  body       :text
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :body, presence: true,
                   uniqueness: {scope: :post}

  delegate :full_name, to: :user, prefix: true, allow_nil: :true
  
end
