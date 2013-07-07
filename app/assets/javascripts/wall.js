
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
  /*  
    var boldhtml = "<button type='button' id='bold" + postIDstr + "' class='bold'>B</button>";
    var italhtml = "<button type='button' id='italic" + postIDstr + "' class='italic'>I</button>";
    var underhtml = "<button type='button' id='underline" + postIDstr + "' class='underline'>U</button>";
  */  
    $("#post" + postIDstr).append($('#edit' + postIDstr));
    $("#post" + postIDstr).append($('#content' + postIDstr));
    $("#post" + postIDstr).append($('#accessor' + postIDstr));
    $("#edit" + postIDstr).append(delhtml)
  /*
    $("#edit" + postIDstr).append(boldhtml)
    $("#edit" + postIDstr).append(italhtml)
    $("#edit" + postIDstr).append(underhtml)
  */
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

    postattr.style.left = e.clientX + 'px';
    postattr.style.top = e.clientY + 'px';
    postID += 1;
  }, false);

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
});