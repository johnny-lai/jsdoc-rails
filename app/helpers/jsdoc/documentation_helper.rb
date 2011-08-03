module Jsdoc::DocumentationHelper
  # Path helpers
  def welcome_path(*args)
    if ::Rails.configuration.jsdoc.single_project
      version_welcome_path(@version.version_number, *args)
    else
      project_welcome_path(@project.slug, @version.version_number, *args)
    end
  end
  
  def symbol_path(*args)
    if ::Rails.configuration.jsdoc.single_project
      version_symbol_path(@version.version_number, *args)
    else
      project_symbol_path(@project.slug, @version.version_number, *args)
    end
  end

  def source_path(*args)
    if ::Rails.configuration.jsdoc.single_project
      version_source_path(@version.version_number, *args)
    else
      project_source_path(@project.slug, @version.version_number, *args)
    end
  end

  def raw_source_path(*args)
    if ::Rails.configuration.jsdoc.single_project
      version_raw_source_path(@version.version_number, *args)
    else
      project_raw_source_path(@project.slug, @version.version_number, *args)
    end
  end


  def symbols
    return Jsdoc::Symbol.order(:alias)
  end

  def namespaces
    return Jsdoc::Symbol.namespaces
  end

  def anchorName(member)
    anchor = ''

    anchor += 'static_' if member.is_static
    anchor += 'method_' if member.is_a?(Jsdoc::Function) and member.symbol.present?
    anchor += 'property_' if member.is_a?(Jsdoc::Property)
    anchor += member.name
  end

  def full_class_list
    output = '<ul>'
    Jsdoc::Symbol.where(:member_of => nil).each do |child|
      output += '<li>' + link_to(list_namespace(child), symbol_path(child.alias)) + '</li>'
    end
    output += '</ul>'
    return output.html_safe
  end

  def list_namespace(namespace)
    output = namespace.name
    if namespace.children.size > 0
      output += '<ul>'
      for child in namespace.children
        output += '<li>' + link_to(list_namespace(child), symbol_path(child.alias)) + '</li>'
      end
      output += '</ul>'
    end


    return output.html_safe
  end

  def link_to_symbol(symbol_type)
    return nil if symbol_type.blank?

    symbol = Jsdoc::Symbol.where(:alias => symbol_type).first
    return symbol_type if symbol.nil?

    return link_to(symbol_type, symbol.alias)
  end
end
