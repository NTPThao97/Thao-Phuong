$(document).ready(function(){
  $(".active-check").click(function(activeClick){
    var active_id = $(activeClick.target).closest('tr').find('.active-id').html();
    var active = activeClick.target.checked;
    $.ajax(
    {
      url: `/decentralizations/${active_id}`,
      method: 'patch',
      data: {
        active_id,
        active
      },
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      },
    });
  });
});
