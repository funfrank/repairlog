module ApplicationHelper
  def error_messages_for(object)
    I18n.with_options :scope => [:errors, :template] do |locale|
      locale.t :header, :count => object.errors.count, :model => object.class.model_name.human.downcase
    end
  end
  
  def link_to_l(*params)
    eval 'link_to ' + params_to_l(*params) 
  end
  
  def button_tag_l(*params)
    eval 'button_tag' + params_to_l(*params)
  end
  
  def header_for(word)
    MyI18n.localize(word, :header)
  end

  def destroy_prompt
    MyI18n.localize('prompt', :link)
  end

  def to_date(date)
    date.to_date if date
  end

  def title_for(word)
    MyI18n.localize_record_attribute(params[:controller].singularize, word) 
  end

  def op_action
    params[:action]
  end

  def label_for(word)
    label_tag MyI18n.localize(word)    
  end

  def close_win_button
    button_to_function MyI18n.localize('close', :link), "hidden_win_div();return false;" 
  end

  def aa
    RepairLog.where(:id=>2)[0]
  end
    

private

  def params_to_l(*params)
   contents = '"%s"' % MyI18n.localize(params[0], :link) 

    i = 1
    while i < params.length
      contents << ', ' unless i == params.length
      contents << 'params[%i]'%i
      i += 1
    end
    
    contents
  end

end

