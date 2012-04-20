# == Schema Information
#
# Table name: items
#
#  id           :integer         not null, primary key
#  usuario_id   :integer
#  detalle      :string(255)
#  reporte      :string(255)
#  estado       :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  recogido_por :string(255)
#  ac           :integer
#  total        :integer
#

require 'spec_helper'

describe Item do

  let(:cliente) { FactoryGirl.create(:usuario) }  

  before do
    # log_in cliente
    @item = cliente.items.build(detalle: "Lorem ipsun", estado: "recibido") 
  end

  subject { @item }

  it { should respond_to(:detalle) }
  it { should respond_to(:reporte) }
  it { should respond_to(:estado) }
  its(:usuario) { should == cliente }

  it { should be_valid }

  describe "when usuario id no esta presente" do
    before { @item.usuario_id = nil }
     it { should_not be_valid }
  end  

  describe "reporte too logn" do
    before { @item.detalle = "a" * 501 }
    it { should_not be_valid }
  end
end
