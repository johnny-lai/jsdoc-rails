module Jsdoc
  class Example < ActiveRecord::Base
    attr_protected
    belongs_to :example_for, :polymorphic => true
  end
end
