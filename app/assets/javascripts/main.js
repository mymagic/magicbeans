function show_logs() {
    var spinner = $('<img class="center-block img-responsive" width="40" height="40" src="/three-dots.svg">');
    var notification = $('#notification')
    notification.empty();
    spinner.prependTo(notification);
    $.get( "/logs.json")
        .done(function(data){
            $.each(data, function(index, log) {
                $(  "<li>\
                  <a href=\"/"+ log.log_type +"/"+ log.type_id +"\">\
                    <div>\
                      <i class=\"fa fa-tasks fa-fw\"></i> "+ log.title +"\
                      <span class=\"text-muted small pull-right\" style=\"margin-top: 2.7px;\">"+ $.timeago(log.created_at) +"</span>\
                    </div>\
                  </a>\
                </li>\
                <li class=\"divider\"></li>").prependTo(notification)
            });

            $( "<li>\
              <a class=\"text-center\" href=\"/logs\">\
                <strong>See All Audit Log</strong>\
                <i class=\"fa fa-angle-right\"></i>\
              </a>\
            </li>").appendTo(notification);
            spinner.remove();
        });
}

window.setTimeout(function() {
    $(".custom-alert").alert('close')
}, 2000);