if (!window.WebSocket)
  alert("WebSocket not supported by this browser");

function $() { return document.getElementById(arguments[0]); }
function $F() { return document.getElementById(arguments[0]).value; }

function getKeyCode(ev) { if (window.event) return window.event.keyCode; return ev.keyCode; } 

var room = {
  join: function(name) {
    this._username=name;
    var location = 'ws://<%= request.host_with_port %>/games/<%= game_id %>/players/<%= uuid %>'
     // document.location.toString().replace('http:','ws:');
    this._ws=new WebSocket(location);
    this._ws.onopen=this._onopen;
    this._ws.onmessage=this._onmessage;
    this._ws.onclose=this._onclose;
  },
  
  _onopen: function(){
    $('join').className='hidden';
    $('joined').className='';
    $('phrase').focus();
    room._send(room._username,'has joined!');
  },
  
  _send: function(user,message){
    user=user.replace(':','_');
    if (this._ws)
      this._ws.send(user+':'+message);
  },

  chat: function(text) {
    if (text != null && text.length>0 )
        room._send(room._username,text);
  },
  
  _onmessage: function(m) {
    if (m.data){
      var c=m.data.indexOf(':');
      var from=m.data.substring(0,c).replace('<','&lt;').replace('>','&gt;');
      var text=m.data.substring(c+1).replace('<','&lt;').replace('>','&gt;');
      
      var chat=$('chat');
      var spanFrom = document.createElement('span');
      spanFrom.className='from';
      spanFrom.innerHTML=from+':&nbsp;';
      var spanText = document.createElement('span');
      spanText.className='text';
      spanText.innerHTML=text;
      var lineBreak = document.createElement('br');
      chat.appendChild(spanFrom);
      chat.appendChild(spanText);
      chat.appendChild(lineBreak);
      chat.scrollTop = chat.scrollHeight - chat.clientHeight;   
    }
  },
  
  _onclose: function(m) {
    this._ws=null;
    $('join').className='';
    $('joined').className='hidden';
    $('username').focus();
    $('chat').innerHTML='';
  }
  
};



$('username').setAttribute('autocomplete','OFF');
$('username').onkeyup = function(ev) { var keyc=getKeyCode(ev); if (keyc==13 || keyc==10) { room.join($F('username')); return false; } return true; } ;        
$('joinB').onclick = function(event) { room.join($F('username')); return false; };
$('phrase').setAttribute('autocomplete','OFF');
$('phrase').onkeyup = function(ev) {   var keyc=getKeyCode(ev); if (keyc==13 || keyc==10) { room.chat($F('phrase')); $('phrase').value=''; return false; } return true; };
$('sendB').onclick = function(event) { room.chat($F('phrase')); $('phrase').value=''; return false; };