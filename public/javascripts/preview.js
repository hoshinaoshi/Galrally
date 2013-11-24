$(function(){
  // チェック処理
  $(".review_thumb").click(function () {
    id = $(this).attr("id");
    check_box = $("#check_" + id)
    if(check_box.val() == 1){
      check_box.attr("value", 0);
      $(this).fadeTo("4000",1.0);
    }else{
      check_box.attr("value", 1);
      $(this).fadeTo("4000",0.3);
    }
  });

  // 画像切り替え処理
  $('.review_thumb').hover(
    function () {
      id = $(this).attr("id");
      $("#" + id).cycle({
        fx:'none',
        speed: 500,
        timeout: 1
      });
    },
    function () {
      id = $(this).attr("id");
      $("#" + id).cycle({
        fx:'none',
        speed: 0,
        timeout: 0
      });
    }
  );
});
