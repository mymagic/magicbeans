$(function() {
    $('#side-menu').metisMenu();
});

//Loads the correct sidebar on window load,
//collapses the sidebar on window resize.
// Sets the min-height of #page-wrapper to window size
$(function() {
    $(window).bind("load resize", function() {
        topOffset = 50;
        width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
        if (width < 768) {
            $('div.navbar-collapse').addClass('collapse')
            topOffset = 100; // 2-row-menu
        } else {
            $('div.navbar-collapse').removeClass('collapse')
        }

        height = (this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height;
        height = height - topOffset;
        if (height < 1) height = 1;
        if (height > topOffset) {
            $("#page-wrapper").css("min-height", (height) + "px");
        }
    })
});

function show_logs() {
    $('ul[data-toggle="dropdown-list"]').empty();
    $.get( "/logs.json", function( data ) {
        $.each(data, function(index, log) {
            $(  "<li>\
                  <a href=\"/"+ log.log_type +"/"+ log.type_id +"\">\
                    <div>\
                      <i class=\"fa fa-tasks fa-fw\"></i> "+ log.title +"\
                      <span class=\"text-muted small pull-right\" style=\"margin-top: 2.7px;\">"+ $.timeago(log.created_at) +"</span>\
                    </div>\
                  </a>\
                </li>\
                <li class=\"divider\"></li>")
                .prependTo($('ul[data-toggle="dropdown-list"]'))
        });
        $( "<li>\
              <a class=\"text-center\" href=\"/logs\">\
                <strong>See All Audit Log</strong>\
                <i class=\"fa fa-angle-right\"></i>\
              </a>\
            </li>").appendTo($('ul[data-toggle="dropdown-list"]'))
    })
}
