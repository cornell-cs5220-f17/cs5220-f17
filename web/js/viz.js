// -- Visualization for moshpit

var c;
var ctx;

// Set up event handler for file load
$(document).ready(function() {
  $('#files').bind('change', handleFileSelect);
  c = document.getElementById("canvas");
  ctx = c.getContext("2d");
});

// Handle load
function handleFileSelect(evt) {
  var files = evt.target.files;
  var file = files[0];
  var reader = new FileReader();
  reader.onload = function(e) {
    var arrayBuffer = e.target.result;
    var data = new Uint16Array(arrayBuffer);
    var npart = data[1] * 0xFFFF + data[0];
    var nframe = (data.length-2)/(3 * npart);
    var output = '';

    output += '<span style="font-weight:bold;">';
    output += escape(file.name) + '</span><br/>\n';
    output += ' - Frames: ' + nframe + '<br/>\n';
    output += ' - Parts:  ' + npart + '<br/>\n';
    $('#list').append(output);

    for (var i = 2; i < data.length; i += 3) {
        data[i+1] = 10 + Math.floor(data[i+1] * 500.0/65536);
        data[i+2] = 10 + Math.floor(data[i+2] * 500.0/65536);
    }
                        
    var frame = 0;
    function animate() {
      if (frame >= nframe) { frame = 0; }
      plotFrame(data, npart, frame);
      ++frame;
    }
    setInterval(animate, 50);
  }
  reader.readAsArrayBuffer(file);
}

// Plot initial particle positions
function plotFrame(data, npart, frameid) {
  ctx.clearRect(0, 0, c.width, c.height);
  ctx.fillStyle = 'red';
  var offset = 3 * frameid * npart + 2;
  for (var i = 0; i < npart; ++i) {
    var tag = data[offset+3*i+0];
    var x   = data[offset+3*i+1];
    var y   = data[offset+3*i+2];
    ctx.beginPath();
    if (tag) {
      ctx.arc(x, y, 4, 0, 2*Math.PI);
      ctx.fill();
    } else {
      ctx.arc(x, y, 2, 0, 2*Math.PI);
      ctx.stroke();
    }
  }
}
    
