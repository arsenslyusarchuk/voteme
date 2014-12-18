require 'spec_helper'

describe User, "relationships" do
  it { should have_many(:polls)}
  it { should have_and_belong_to_many :answers }
end
