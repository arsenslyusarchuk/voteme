require 'spec_helper'

describe Poll, "relationships" do
  it { should have_many(:answers).dependent(:destroy) }
  it { should belong_to :user }
  it { should accept_nested_attributes_for :answers}
end

describe Poll, "validations" do
  it { should validate_inclusion_of(:poll_type).in_array(%w(radio checkbox)) }
  it { should validate_presence_of :title }
  it { should validate_length_of(:title).is_at_most(128) }
  it { should validate_presence_of :description }
  it { should validate_length_of(:description).is_at_most(256) }
end
