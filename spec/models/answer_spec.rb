require 'spec_helper'

describe Answer, "relationships" do
  it { should have_and_belong_to_many :users }
  it { should belong_to :poll}
end

describe Poll, "validations" do
  it { should validate_presence_of :title }
  it { should validate_length_of(:title).is_at_most(128) }
end
