# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#1.Deal with the state of repair_log changed to taked.
$ ->
  TAKE = '5'

  $("select#repair_log_state_id").change ->
    if $("select#repair_log_state_id").attr('value')==TAKE
       d = new Date()
       $("#repair_log_outDate_1i").attr('value', d.getFullYear())
       $("#repair_log_outDate_2i").attr('value', d.getMonth() + 1)
       $("#repair_log_outDate_3i").attr('value', d.getDate())
       $("div#outDate").show("slow")
    else
       $("#repair_log_outDate_1i").attr('value', '')
       $("#repair_log_outDate_2i").attr('value', '')
       $("#repair_log_outDate_3i").attr('value', '')
       $("div#outDate").hide(1000)


#2.add the item of devices_repair_logs       
$ ->
  delete_text = '<%=MyI18n.localize("delete", :link)%>'
  $("div#devices_repair_logs button").click ->
    $('input#devices_repair_logs_length').attr('value', parseInt($('input#devices_repair_logs_length').attr('value')) + 1)
    $('<div><input type="hidden" value="'+$("select#device_id").attr('value')+'" name="repair_log[devices_repair_logs_attributes]['+ $('input#devices_repair_logs_length').attr('value')+'][device_id]"/>' + $('select#device_id').find("option:selected").text() + ' <a href="#" onclick="this.parentElement.parentNode.removeChild(this.parentElement)">'+delete_text+'</a><br>' + '</div>').appendTo($("div#devices_repair_logs"))
    
#3.delete the item of devices_repair_logs
$ ->
  $("div#devices_repair_logs a").click ->
    this.parentElement.parentNode.removeChild(this.parentElement)


#4.Get last repair_log        
$ ->
  $("div#record button").click ->
    $.ajax({
        type: "GET",
        url: 'last_repair_log?'+ (if $('input#posid').attr('value') then 'posid='+$('input#posid').attr('value')+'&id=' +$('input#id').attr('value') else 'posid='+$('input#repair_log_posid').attr('value') ),
        data:   'text',
        success: (data)->
          $("div#win").html(data)
          show_win_div()
          $("div#recoveried").show("slow")
        })

#5.Get contractor and phone        
$ ->
  $("div#company button").click ->
    $.ajax({
        type: "GET",
        url: 'contractor_phone?'+ (if $('input#posid').attr('value') then 'posid='+$('input#posid').attr('value')+'&id=' +$('input#id').attr('value') else 'posid='+$('input#repair_log_posid').attr('value'))+'&company_id=' +$('select#repair_log_company_id').attr('value') ,
        data:   'text',
        success: (data)->
          $('input#repair_log_contractor').attr('value', data.split('|')[0])
          $('input#repair_log_phone').attr('value', data.split('|')[1])
        })

$ ->
  $("div#login_category select").change ->
    $.ajax({
        url: 'category_areas?category_id='+ $("select#user_category_id").attr('value')
        data:   'text',
        success: (data)->
          $("select#user_area_id").html(data)
        })



$ ->
  $("div#stock_in button").click ->
    $("div#stock_in button")[0].innerHTML = 'stock_in'



$ ->
  create_fade_div();
  create_win_div();
  create_progress_bar_div();

  

