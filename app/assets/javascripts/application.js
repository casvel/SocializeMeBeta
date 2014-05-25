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
    $('a[href="/users/sign_in"]').toggle(1);

    $('#new_tweet').on('shown.bs.dropdown', function(){
        $('#new_tweet').fadeOut('slow');
    });
});
