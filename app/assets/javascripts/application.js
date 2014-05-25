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
//= require turbolinks
//= require_tree .

$(document).ready(function(){
    $('#myalert').delay(1000).toggle(1000);

    $('.field_with_errors').removeAttr('class');
    $('#error_explanation').removeAttr('id');
    $('input[type=submit]').addClass('btn btn-default');
    $('#user_email').addClass('form-control').width('250px');
    $('a[href="/users/sign_in"]').hide();

    var $background;
    $('.list-group-item').mouseenter(function(){
        $background = $(this).css("background-color");
        $(this).css("background-color", "#383f71");
    });

    $('.list-group-item').mouseleave(function(){
        $(this).css("background-color", $background);
    });

    $("ul.dropdown-menu").on("click", "[data-stopPropagation]", function(e) {
        e.stopPropagation();
    });

});
