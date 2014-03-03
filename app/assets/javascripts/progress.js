window.onload=function() {
  create_fade_div();
  create_win_div();
  create_progress_bar_div();
}

function create_fade_div() {
  var newElement = document.createElement('div'); 
  document.body.appendChild(newElement);
  newElement.id = 'fade'; 
  newElement.className = 'fade'; 
} 

function create_win_div() {
  var newElement = document.createElement('div'); 
  document.body.appendChild(newElement);
  newElement.id = 'win'; 
  newElement.className = 'win';
   
} 

function create_progress_bar_div() {
  var newElement = document.createElement('div'); 
  document.body.appendChild(newElement);
  newElement.id = 'progress_bar'; 
  newElement.className = 'progress_bar'; 
} 


function show_win_div() {
  document.getElementById('win').style.display='block';
  document.getElementById('fade').style.display='block';
}

function hidden_win_div() {
  document.getElementById('win').style.display='none';
  document.getElementById('fade').style.display='none';
}


function processPrint() {
  w=window.open();
  newstr = '<link href="/assets/print.css" rel="stylesheet" type="text/css">' + $('div#PrintDiv').html() + '<a href="#" onclick="window.print();false;">Print</a>'
  w.document.write(newstr);
}
