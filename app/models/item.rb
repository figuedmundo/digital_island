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

class Item < ActiveRecord::Base
  attr_accessible :detalle, :estado, :reporte, :recogido_por, :ac, :trabajo, :repuesto, :tecnico
  belongs_to :usuario

  before_validation :cuentas_to_i
  before_save :calc_total


  validates :usuario_id,  presence: true

  validates :detalle,     presence: true,
                          length: { maximum: 200 }

  validates :estado,      presence: true

  validates :reporte,     length: { maximum: 200 }

  validates :recogido_por,  length: { maximum: 50 }

  validates :ac,          numericality: { only_integer: true, 
                                          greater_than_or_equal_to: 0 },
                          length: { maximum: 5 }              

  validates :total,       numericality: { only_integer: true, 
                                          greater_than_or_equal_to: 0 },
                          length: { maximum: 5 }              

  validates :trabajo,     numericality: { only_integer: true, 
                                          greater_than_or_equal_to: 0 },
                          length: { maximum: 5 }              

  validates :repuesto,    numericality: { only_integer: true, 
                                          greater_than_or_equal_to: 0 },
                          length: { maximum: 5 }              

  validates :tecnico,     length: { maximum: 50 }


  default_scope order: 'items.created_at DESC'



private
  
  def cuentas_to_i
    self.ac = ac.to_i
    self.total = total.to_i
    self.trabajo = trabajo.to_i
    self.repuesto = repuesto.to_i
  end

  def calc_total
    self.total = self.trabajo + self.repuesto
  end

end

