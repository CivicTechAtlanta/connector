require 'rails_helper'

RSpec.describe Project, :type => :model do
  subject { FactoryGirl.create(:project) }

  describe "url validation" do
    it "handles empty urls" do
      subject.urls = []
      expect(subject).to be_valid
    end

    it "handles valid urls" do
      subject.urls = [["Code Repository", Faker::Internet.url], ["Website", Faker::Internet.url]]
      expect(subject).to be_valid
    end

    it "handles invalid urls" do
      subject.urls = [["CodeRepository", Faker::Internet.url]]
      expect(subject).not_to be_valid
    end

    it "compiles descriptions to markdown" do
      output = "<h1>A First Level Header</h1>\n\n<h2>A Second Level Header</h2>\n\n<p>Now is the time for all good men to come to\nthe aid of their country. This is just a\nregular paragraph.</p>\n\n<p>The quick brown fox jumped over the lazy\ndog&#39;s back.</p>\n\n<h3>Header 3</h3>\n\n<blockquote>\n<p>This is a blockquote.</p>\n\n<p>This is the second paragraph in the blockquote.</p>\n\n<h2>This is an H2 in a blockquote</h2>\n</blockquote>\n"
      expect(subject.markdown).to eq(output)
    end
  end
end
