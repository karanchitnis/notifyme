
  var wall = document.getElementById("wall");
  var postID = 0;
  wall.addEventListener('dblclick', function(e) {
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
  
    $("#post" + postIDstr).append($('#edit' + postIDstr));
    $("#post" + postIDstr).append($('#content' + postIDstr));
    $("#post" + postIDstr).append($('#accessor' + postIDstr));

    $(".post").draggable().click(function(){
      if ($(this).is('.ui-draggable-dragging')) {
        return;
      }
      var postid = $(this).attr("id");
      $(".post").draggable( "option", "disabled", true );
      $(".content").attr('contenteditable',true);
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

    postattr.style.left = e.clientX + 'px';
    postattr.style.top = e.clientY + 'px';
    postID += 1;
  }, false);