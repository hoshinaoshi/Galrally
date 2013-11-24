function page_handler(event) {
  next_page = Number($("#next_page_btn").attr("value")) + 1
  tag_id =$("#tag_id").attr("value")
  url = "/top?tag_id=" + tag_id + "&page="
  if(tag_id){
    url = "/tags/" + tag_id + "?page="
  }
  if(next_page > Number($("#page_num").attr("value"))){
    $("#progress").hide();
    return
  }
  $.ajax({
    type: "GET",
    url: url + next_page,
    dataType: "script",
    cache:true,
    success: function(){
      $("#progress").hide();
      $("#next_page_btn").attr("disabled",false)
    }
  });
};

$(function(){
  // ページング
  $("#next_page_btn").click(function (e) {
    $("#progress").show();
    page_handler(e);
    $(this).attr("disabled",true)
  });

  // 詳細表示
  $(".listview-item").click(function () {
    id = $(this).attr("id");
    
    // 選択画像をわかりやすく
    if($(this).attr("value") == 0){
      $(this).attr("value", 1);
      $(this).fadeTo("4000",0.5);
      site = $(this).find("div.review_thumb").find("img").attr("name")
      if( site == 0){
        $("#show_detail").append("<iframe id='show_detail_" + id + "' src='http://flashservice.xvideos.com/embedframe/" + id +"' frameborder=0 width=510 height=400 scrolling=no></iframe>")
      }else if( site == 1){
        $("#show_detail").append("<iframe id='show_detail_" + id + "' src='http://www.spankwire.com/EmbedPlayer.aspx?ArticleId="+ id +"' frameborder='0' height='530' width='660' scrolling='no'></iframe>")
      }else if( site == 2){
        $("#show_detail").append("<iframe id='show_detail_" + id.replace(/[\/%]/g,"_") + "' src='http://www.tube8.com/embed/asian/"+ id +"' frameborder='0' height='481' width='608' scrolling='no'></iframe>")
      }else if( site == 3){
        $("#show_detail").append("<iframe id='show_detail_" + id + "' src='http://www.tokyo-tube.com/media/player/player.swf?f=http://www.tokyo-tube.com/media/player/config_embed.php?vkey="+ id +"' frameborder='0' height='400' width='510' scrolling='no'></iframe>")
      }else if( site == 4){
        $("#show_detail").append("<iframe id='show_detail_" + id + "' src='http://asg.to/blogFrame.html?mcd="+ id +"&width=475&height=397' style='width: 475px; height: 397px; border: none;' frameborder='0' scrolling='no'></iframe>")
      }
    }else{
      $(this).attr("value", 0);
      $(this).fadeTo("4000",1.0);
      id = id.replace(/[\/%]/g,"_")
      $("#show_detail_" + id).fadeTo("4000",0);
      $("#show_detail_" + id).remove();
    }
  });

  // ページ遷移ボタンTOPへボタンを追従
  var nav = $('#next_page_btn');
  var topBtn = $('#top_btn');
  topBtn.hide();

  offset = nav.offset();

  $(window).scroll(function () {
    if($(window).scrollTop() > offset.top) {
      nav.addClass('fixed');
      topBtn.fadeIn();
    } else {
      nav.removeClass('fixed');
      topBtn.fadeOut();
    }
  });

  topBtn.click(function () {
    $('body,html').animate({
      scrollTop: 0
    }, 500);
    return false;
  });
});
