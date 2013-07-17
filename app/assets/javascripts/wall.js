
  var wall = document.getElementById("wall");
  var addPost = document.getElementById("addPost");
  var postID = 0;
  
  addPost.addEventListener('click', function(e) {
    addPostToPage(e);
  }, false);

  wall.addEventListener('dblclick', function(e) {
    addPostToPage(e);
  }, false);

function addPostToPage(e) {
  postattr = document.createElement("div");
  postattr.className = 'post';
  postattr.id = 'post' + postID.toString();
  document.body.appendChild(postattr);
    
  editattr = document.createElement("div");
  editattr.className = 'edit';
  editattr.id = 'edit' + postID.toString();
  document.body.appendChild(editattr);
    
  contentattr = document.createElement("div");
  contentattr.className = 'content';
  contentattr.id = 'content' + postID.toString();
  document.body.appendChild(contentattr);
   
  accessorattr = document.createElement("div");
  accessorattr.className = 'accessor';
  accessorattr.id = 'accessor' + postID.toString();
  document.body.appendChild(accessorattr);
    
  //$(".post").append('<img id="delete" src="assets/delete.png" />').css("opacity", "1" );
  var postIDstr = postID.toString();  
  var delhtml = "<img id='delete" + postIDstr + "' class='delete' src='assets/delete.png' />"
  
/*  
  var boldhtml = "<button type='button' id='bold" + postIDstr + "' class='bold'>B</button>";
  var italhtml = "<button type='button' id='italic" + postIDstr + "' class='italic'>I</button>";
  var underhtml = "<button type='button' id='underline" + postIDstr + "' class='underline'>U</button>";
*/

  var linkhtml = "<button type='button' id='link" + postIDstr + "' class='link'>Embed</button>";
    
  $("#post" + postIDstr).append($('#edit' + postIDstr));
  $("#post" + postIDstr).append($('#content' + postIDstr));
  $("#post" + postIDstr).append($('#accessor' + postIDstr));
  $("#edit" + postIDstr).append(delhtml);
  $("#edit" + postIDstr).append(linkhtml);

  $(".post").draggable().click(function(){
    if ($(this).is('.ui-draggable-dragging')) {
      return;
    }
    var postid = $(this).attr("id");
    $(".post").draggable( "option", "disabled", true );
    $(".content").attr('contenteditable',true);
    //console.log($(".content").html());
  });

  $(".content").blur(function(){
    var contentid = $(this).attr("id");
    contentid = contentid.substring(7);
    $(".post").draggable( 'option', 'disabled', false);
    var contentid = $(this).attr('id');
    $(".content").attr('contenteditable',false);
  });

  $(".delete").click(function(event){
    var deleteid = $(this).attr("id");
    deleteid = deleteid.substring(6);
    $("#post" + deleteid).remove();
  });

/*
    $(".bold").click(function(){
      //var contentid = $(this).attr('id');
      alert(contentid);
      //contentid = contentid.substring(4);
      //console.log(contentid);
      //$(".content").attr('contenteditable', true);
      $(".content").attr('contenteditable', true);
      document.execCommand('bold',false,null);
    });
    });

    $(".italic").click(function(){
      var contentid = $(this).attr('id');
      contentid = contentid.substring(6);
      $("#content" + contentid).attr('contenteditable', true);
      document.execCommand('italic',false,null);
    });

    $(".underline").click(function(){
      var contentid = $(this).attr('id');
      contentid = contentid.substring(9);
      $("#content" + contentid).attr('contenteditable', true);
      document.execCommand('underline',false,null);
    });
*/

  if (e.clientX < 144)
    postattr.style.left = "180px";
  else
    postattr.style.left = e.clientX + 'px';
  if (e.clientX < 60)
    postattr.style.top = "60px";
  else
    postattr.style.top = e.clientY + 'px';
  postID += 1;
  
  $(document).ready(function(){
    $(".bold").click(function(){
      $(".content").attr('contenteditable', true);
      document.execCommand('bold',false,null);
    });
    $(".italic").click(function(){
      $(".content").attr('contenteditable', true);
      document.execCommand('italic',false,null);
    });
    $(".underline").click(function(){
      $(".content").attr('contenteditable', true);
      document.execCommand('underline',false,null);
    });
    $(".link").click(function(){
      var linkid = $(this).attr('id');
      contentid = linkid.substring(4);
      var text = $("#content" + contentid).text();
      $.ajax(
      {
        type:'POST',
        url:'/ajax/embed_link',
        data: 'text=' + text 
          + '&contentid=' + contentid 
      })     
    });
  });
}