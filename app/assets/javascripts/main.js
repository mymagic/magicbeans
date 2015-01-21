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


$(document).on('ready page:load', function () {
  var program_tags = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    limit: 10,
    remote: 'api/programs/tags?q=%QUERY'
  });
   
  // kicks off the loading/processing of `local` and `prefetch`
  program_tags.initialize();
   
  // passing in `null` for the `options` arguments will result in the default
  // options being used
  $('#program-typeahead').typeahead(null, {
    name: 'tags',
    displayKey: 'name',
    // `ttAdapter` wraps the suggestion engine in an adapter that
    // is compatible with the typeahead jQuery plugin
    source: program_tags.ttAdapter()
  });

  var activity_tags = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    limit: 10,
    remote: 'api/activities/tags?q=%QUERY'
  });
   
  // kicks off the loading/processing of `local` and `prefetch`
  activity_tags.initialize();
   
  // passing in `null` for the `options` arguments will result in the default
  // options being used
  $('#activity-typeahead').typeahead(null, {
    name: 'tags',
    displayKey: 'name',
    // `ttAdapter` wraps the suggestion engine in an adapter that
    // is compatible with the typeahead jQuery plugin
    source: activity_tags.ttAdapter()
  });



  var users = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    limit: 10,
    remote: 'users?q=%QUERY'
  });
   
  // kicks off the loading/processing of `local` and `prefetch`
  users.initialize();
   
  // passing in `null` for the `options` arguments will result in the default
  // options being used
  $('#user-typeahead').typeahead(null, {
    name: 'users',
    displayKey: 'name',
    // `ttAdapter` wraps the suggestion engine in an adapter that
    // is compatible with the typeahead jQuery plugin
    source: users.ttAdapter()
  });
});