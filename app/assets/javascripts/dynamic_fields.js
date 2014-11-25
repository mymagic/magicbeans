//Add Field
function add_field(button, association, content) {  
  var new_id = new Date().getTime();  
  var regexp = new RegExp("new_" + association, "g");

  $(button).button('loading');
  setTimeout(function () {
        $(button).button('reset')
    }, 3000);

  $(content.replace(regexp, new_id))
        .hide()
        .insertBefore($(button))
        .fadeIn(250);

  $(button).button('reset');
}

//Remove Field
$(document).on('ready page:load', function () {
  $("form").on('click', 'span[data-toggle="nestedfield"]', function() {
    var checkbox = $(this).children().eq(1);
    checkbox.prop('checked', true);
    $(this).parents().eq(1).hide(250, function(){
        $(this).hide();
      })
  });
});