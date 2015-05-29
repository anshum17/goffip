class Enum < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.get_list
    self.constants.map{|x| x.to_s}
  end

  def self.get_mapping_readable
    object = {}
    self.get_list.each { |x|
      object[x.to_s] = x.gsub('_'," ").downcase.camelize
    }
    return object
  end

  def self.get_collection
    self.constants.map{|x| [x.to_s, x.to_s]}
  end

  def self.get_mapping
    object = {}
    self.constants.each { |x|
      object[x.to_s] = const_get(x)
    }
    return object
  end

  def self.get_name index
    self.constants.find{|name| const_get(name) == index}.to_s
  end

  def self.get_index s_name
    const_get(self.constants.find{|name| name.to_s == s_name}) rescue nil
  end

  def self.get_names indexes
    names = []
    indexes.each {|index| names << self.get_name(index)}
    names
  end

end
