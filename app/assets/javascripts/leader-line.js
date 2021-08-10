$(document).ready(function () {

  Object.keys(data).forEach(function(key) {

    num = parseInt(key) + 1;

    if (data[key]){
      new LeaderLine(
        document.getElementById("box_" + key),
        document.getElementById("box_" + num), {
          color: '#d2b48c',
          endPlug: 'behind',
          size: 10
        }
      );
    }else {
      new LeaderLine(
      document.getElementById("box_" + key),
        document.getElementById("box_" + num),{
          color: '#696969',
          endPlug: 'behind',
          dash: {len: 5, gap: 9},
        }
      );
    }
  });
});
