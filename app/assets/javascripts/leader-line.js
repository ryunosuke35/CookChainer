$(document).ready(function () {

  Object.keys(data).forEach(function(key) {

    num = parseInt(key) + 1;

    if (data[key]){
      new LeaderLine(
        document.getElementById("box_" + key),
        document.getElementById("box_" + num), {
          color: '#d2b48c',
          dropShadow: {color: '#aaa', dx: 4, dy: 3, blur: 3, opacity: 1},
          endPlugSize: 0.1
        }
      );
    }else {
      new LeaderLine(
      document.getElementById("box_" + key),
        document.getElementById("box_" + num),{
          color: '#696969',
          dropShadow: {color: '#aaa', dx: 4, dy: 3, blur: 3, opacity: 1},
          dash: {animation: true, len: 5, gap: 9},
          endPlugSize: 0.1
        }
      );
    }
  });
});
