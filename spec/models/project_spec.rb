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
      subject.description = <<-eos
A First Level Header
====================

A Second Level Header
---------------------

Now is the time for all good men to come to
the aid of their country. This is just a
regular paragraph.

The quick brown fox jumped over the lazy
dog's back.

### Header 3

> This is a blockquote.
> 
> This is the second paragraph in the blockquote.
>
> ## This is an H2 in a blockquote
      eos
      output = "<h1 id=\"a-first-level-header\">A First Level Header</h1>\n\n<h2 id=\"a-second-level-header\">A Second Level Header</h2>\n\n<p>Now is the time for all good men to come to\nthe aid of their country. This is just a\nregular paragraph.</p>\n\n<p>The quick brown fox jumped over the lazy\ndog’s back.</p>\n\n<h3 id=\"header-3\">Header 3</h3>\n\n<blockquote>\n  <p>This is a blockquote.</p>\n\n  <p>This is the second paragraph in the blockquote.</p>\n\n  <h2 id=\"this-is-an-h2-in-a-blockquote\">This is an H2 in a blockquote</h2>\n</blockquote>\n"
      expect(subject.markdown).to eq(output)
    end
  end
end
