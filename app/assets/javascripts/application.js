// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

$(".project-form").on("click", ".remove", function(event) {
  event.preventDefault();

  $(this).closest(".row").remove();
});

$(".project-form").on("click", ".new-url", function(event) {
  event.preventDefault();

  var row = $("#url-template").clone();
  row.removeClass("hidden");
  row.find("input").val("");

  $(this).before(row);
});

// Set up
$(document).ready(  function() {
  var number = "0xFF9481";
  $("form").append('<input type="hidden" name="imahuman" class="imahuman" value="0" />')
  .focus( function() {
    this.imahuman.value = parseInt(number, 16);
  })
  .click( function() {
    this.imahuman.value = parseInt(number, 16);
  });
});
