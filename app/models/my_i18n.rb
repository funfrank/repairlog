class MyI18n

  def self.localize(word, key=:link) 
    contents = ''
    word.split(' ').map do |w|
      contents <<  unless translation_missing? localize_view(w, key)
                     localize_view(w, key)
                   else  
                     localize_record(w)
                   end
    end
    
    contents
  end

  def self.localize_view(word, key)
    I18n.with_options :scope => [:activeview, key] do |locale|
      locale.t word.downcase
    end  
  end
  
  def self.localize_record(word)
    I18n.with_options :scope => [:activerecord, :models] do |locale|
      locale.t word.singularize.downcase
    end  
  end

  def self.localize_record_attribute(model, word)
    I18n.with_options :scope => [:activerecord, :attributes, model] do |locale|
      locale.t word
    end  
  end
  
private

  def self.translation_missing?(word)
    word.include?('translation missing')
  end

end
