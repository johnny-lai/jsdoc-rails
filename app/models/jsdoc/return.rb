module Jsdoc
  class Return < ActiveRecord::Base
    attr_protected
    belongs_to :function
  end
end
