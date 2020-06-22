// This is the only way i found to allow Materialize select tag to work.
document.addEventListener('DOMContentLoaded', function() {
  var elems = document.querySelectorAll('select');
  var options = document.querySelectorAll('option');
  var instances = M.FormSelect.init(elems, options);
});
