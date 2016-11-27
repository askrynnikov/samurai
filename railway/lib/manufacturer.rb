# frozen_string_literal: true
# manufacturer has
module Manufacturer
  attr_reader :manufacturer

  def manufacturer=(manufacturer)
    @manufacturer ||= manufacturer
  end
end
