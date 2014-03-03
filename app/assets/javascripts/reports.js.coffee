# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
   d = new Date()
   $("#repair_log_outDate_start_1i").attr('value', d.getFullYear())
   $("#repair_log_outDate_start_2i").attr('value', d.getMonth() + 1)
   $("#repair_log_outDate_start_3i").attr('value', d.getDate())
   
