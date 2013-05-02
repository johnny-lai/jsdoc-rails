module Jsdoc
  class Param < ActiveRecord::Base
    attr_protected
    belongs_to :function

    default_scope order('"order"')
  end
end
