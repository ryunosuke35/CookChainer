$(document).ready(function () {

  Object.keys(data).forEach(function(key) {

    num = parseInt(key) + 1;

    if (data[key]){
      new LeaderLine(
        document.getElementById("box_" + key),
        document.getElementById("box_" + num), {
          color: '#696969',
          endPlugSize: 0.1
        }
      );
    }else {
      new LeaderLine(
      document.getElementById("box_" + key),
        document.getElementById("box_" + num),{
          dash: {animation: true, len: 5, gap: 9},
          color: '#696969',
          endPlugSize: 0.1
        }
      );
    }
  });
});
