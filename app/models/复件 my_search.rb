module MySearch
  extend ActiveSupport::Concern
  DATA_FILE = "config//locales//%s.yml" %I18n.locale 

  attr_accessor :datetime_attrs
  attr_accessor :order_attrs

  module ClassMethods

    def searcher(attrs)
      s = include.new
      s.dynamic_conditions_clauses
      s.datetime_attrs.each do |a|
        eval("s.#{a}_start=take_date_select(attrs, '#{a}_start')")
        eval("s.#{a}_end=take_date_select(attrs, '#{a}_end')")
      end
      s.attributes = attrs
      s
    end

    def take_date_select(attrs, key)
      date = nil
      unless attrs["#{key}(1i)"].blank? || attrs["#{key}(2i)"].blank? || attrs["#{key}(3i)"].blank? 
        date = Date.new(attrs["#{key}(1i)"].to_i, attrs["#{key}(2i)"].to_i,attrs["#{key}(3i)"].to_i)
      end
      attrs.delete("#{key}(1i)")
      attrs.delete("#{key}(2i)")
      attrs.delete("#{key}(3i)")

      return date
    end

  end

  def dynamic_conditions_clauses
    y = YAML.load(File.open(DATA_FILE))
    module_key = self.class.model_name.singular
    self.datetime_attrs = []

    y[I18n.locale.to_s]['activerecord']['search'][module_key].each do |p|
      #1.attr_accessor
      if p[1] == 'datetime'
        b= %Q{ def #{p[0]}_start  
                 @#{p[0]}_start  
               end  
               def #{p[0]}_start=(value)  
                 @#{p[0]}_start = value 
               end   
               def #{p[0]}_end  
                 @#{p[0]}_end  
               end  
               def #{p[0]}_end=(value)  
                  @#{p[0]}_end = value 
               end  
               }    

        class_eval(b)
        self.datetime_attrs << p[0]  
      end

      #2.conditions
      create_method(p[0] + "_conditions") {
        case  p[1] 
        when 'datetime'
          if !eval("#{p[0]}_start").blank? && !eval("#{p[0]}_end").blank?
            ["#{p[0]}" + " between ? and  ?", eval("#{p[0]}_start"), eval("#{p[0]}_end") ]   
          elsif not eval("#{p[0]}_start").blank?
            ["#{p[0]}" + " >=  ?", eval("#{p[0]}_start") ]   
          elsif not eval("#{p[0]}_end").blank?
            ["#{p[0]}" + " <=  ?", eval("#{p[0]}_end") ]   
          end
        when 'string'
          ["#{p[0]}" + " like ?", "%" + eval("#{p[0]}") +"%"   ]   unless eval("#{p[0]}").blank?
        else
          ["#{p[0]}" + " = ?", eval("#{p[0]}") ]   unless eval("#{p[0]}").blank?
        end
      }
    end

    #3.order
    self.order_attrs = []
    y[I18n.locale.to_s]['activerecord']['order'][module_key].each do |p|
        self.order_attrs << ( p[0] + ' ' + p[1] )
    end


  end  


  def create_method(name, &block)
    self.class.send(:define_method, name, &block)
  end


  def search
    self.class.find(:all, :conditions => conditions, :order => orders)
  end


  private

  def conditions
    [conditions_clauses.join(' AND '), *conditions_options]
  end

  def conditions_clauses
    conditions_parts.map { |condition| condition.first }
  end

  def conditions_options
    conditions_parts.map { |condition| condition[1..-1] }.flatten
  end

  def conditions_parts
    methods.grep(/_conditions$/).map { |m| send(m) }.compact
  end

  def orders
    order_attrs.join(',') 
  end





end
