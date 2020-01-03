$(function() {

  var search_list = $(".contents.row");

  function appendComic(comic) {
    var html = `<div class="content_post">
                  <div class="content_image" style="background-image: url(${comic.image});">
                  </div>
                  <div class="contents">
                    <a class="content_title "href="/comics/${comic.id}" data-method="get" >${comic.title}</a><br>  
                    <p class="content_text">${ comic.text }</p>
                    
                    
      <a class="tags_name" href="/comics?${tag.id}" data-method="get">${tag.name}</a>
    <br><br>


                  <span class="name">
                    <a href="/users/${comic.user_id}">
                      <span>投稿者</span>${comic.nickname}
                    </a>
                  </span>
                </div>
                </div>`
    var current_user = comic.user_sign_in && comic.user_sign_in.id == comic.user_id ? 
                              `<li>
                                <a href="/comics/${comic.id}/edit" data-method="get" >編集</a>
                              </li>
                              <li>
                                <a href="/comics/${comic.id}" data-method="delete" >削除</a>
                              </li>` : "";

    
    search_list.append(html);
   }

   function appendErrMsgToHTML(msg) {
    var html = `<div class='name'>${ msg }</div>`
    search_list.append(html);
  }

  $(".search-input").on("keyup", function() {
    var input = $(".search-input").val();
    $.ajax({
      type: 'GET',
      url: '/comics/search',
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(comics) {
      // search_list.empty();
      $(".contents.row").empty();

      if (comics.length !== 0) {
        comics.forEach(function(comic){
          appendComic(comic);
        });
      }
      else {
        appendErrMsgToHTML("一致する漫画がありません");
      }
    })
  });
});