// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require star-rating.min
//= require_tree .

$(function() {
    /* Carousel script */
    indicators = $('.carousel-indicators li');
    halfSize = indicators.size()/2;
    for (i = 0; i < halfSize; i++) {
        if (!indicators[i].classList.contains('active')) {
            indicators[halfSize + i].classList.add('display-none');
        } else {
            indicators[halfSize + i].classList.remove('display-none');
        }
    }

    $(document).on("click", ".carousel-control", function(e){

        e.preventDefault();

        indicators = $('.carousel-indicators li');
        halfSize = indicators.size()/2;
        for (i = 0; i < halfSize; i++) {
            if (!indicators[i].classList.contains('active')) {
                indicators[halfSize + i].classList.add('display-none');
            } else {
                indicators[halfSize + i].classList.remove('display-none');
            }
        }
    });
    /* End carousel script */

    /* Clear search bar input on page reload */
    $(document).ready( function(e){

        $('.search-bar input#keyword').val("");
    });

    /* Clear success/error messages from top of the page */
    if ($('.content div div div p.success').html() != "") {
        $(document).on("click", "body", function(e){
            $('.content div div div p.success').html("");
        });
    }
    if ($('.content div div div p.error').html() != "") {
        $(document).on("click", "body", function(e){
            $('.content div div div p.error').html("");
        });
    }
});