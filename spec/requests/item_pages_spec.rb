require 'spec_helper'

describe "Items" do
  
  subject { page }
  
  describe "show page" do
    let(:cliente) { FactoryGirl.create(:usuario) }
    before do
      log_in cliente
      
    end
  end
end
