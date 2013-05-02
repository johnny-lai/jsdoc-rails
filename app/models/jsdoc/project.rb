module Jsdoc
  class Project < ActiveRecord::Base
    attr_protected
    has_many :versions, :class_name => 'Jsdoc::Version', :dependent => :destroy
  end
end
