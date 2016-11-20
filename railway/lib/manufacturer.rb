module Manufacturer
  attr_reader :manufacturer

  def manufacturer=(manufacturer)
    @manufacturer ||= manufacturer
  end
end