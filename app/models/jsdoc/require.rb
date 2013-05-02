module Jsdoc
  class Require < ActiveRecord::Base
    attr_protected
    belongs_to :function, :class_name => 'Jsdoc::Function'
  end
end
