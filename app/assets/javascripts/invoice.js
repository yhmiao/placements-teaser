$(document).ready(function() {
  $('#select_campaigns').modal();

  $('#open_search_campaign_link').click(function(event){
    var elem     = $("#select_campaigns");
    var instance = M.Modal.getInstance(elem);

    instance.open();
  });
});
