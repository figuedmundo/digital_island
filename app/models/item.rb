# == Schema Information
#
# Table name: items
#
#  id         :integer         not null, primary key
#  usuario_id :integer
#  detalle    :string(255)
#  reporte    :string(255)
#  estado     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Item < ActiveRecord::Base
  attr_accessible :detalle, :estado, :reporte
  belongs_to :usuario

  validates :usuario_id,  presence: true

  validates :detalle,     presence: true,
                          length: { maximum: 500 }

  validates :estado,      presence: true


  default_scope order: 'items.created_at DESC'


end
