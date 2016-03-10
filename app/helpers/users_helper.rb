# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  email                  :string
#  password_digest        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean          default(FALSE)
#  password_reset_token   :string
#  password_reset_sent_at :datetime
#  last_login_attempt_at  :datetime
#  failed_login_count     :integer
#

module UsersHelper
end
