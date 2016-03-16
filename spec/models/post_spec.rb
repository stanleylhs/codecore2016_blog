require 'rails_helper'
#  id          :integer          not null, primary key
#  title       :string
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  user_id     :integer

RSpec.describe Post, type: :model do
  describe "validations" do
    it "doesn't allow creating a campaign with no name" do 
      post = Post.new
      expect(post.valid?).to eq(false)
    end
    it "requires a title" do
      post = Post.new
      post.valid?
      expect(post.errors).to have_key(:title)
    end
    it "requires a post title that must be longer than 7 chars" do
      post = Post.new(title: "123456")
      post.valid?
      expect(post.errors).to have_key(:title)
    end
    it "requires a content body" do
      post = Post.new
      post.valid?
      expect(post.errors).to have_key(:content)
    end
    context 'has a method body_snippet return 100 char max' do
      context 'shorter than 100 chars' do
        it 'returns the content' do
          post = create(:post, {content: Faker::Lorem.characters(100)})
          expect(post.body_snippet).to eq(post.content)
        end
      end
      context 'longer than 100 chars' do
        it 'returns the first 100 chars and ...' do
          post = create(:post, {content: Faker::Lorem.characters(255)})
          expect(post.body_snippet).to eq(post.content[0..99] + '...')
        end
      end
    end
  end
end
