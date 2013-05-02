module Jsdoc
  class BorrowedProperty < ActiveRecord::Base
    attr_protected
    belongs_to :borrowed_to, :class_name => 'Jsdoc::Symbol'
    belongs_to :borrowed_from, :class_name => 'Jsdoc::Symbol'
    belongs_to :property, :class_name => 'Jsdoc::Property'
  end
end
