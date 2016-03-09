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

module CommentsHelper
end
