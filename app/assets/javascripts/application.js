// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery

var ready;
ready = function(){
  $('#talk').on('click', function(event) {
    if ($('#query').val().trim() != ""){
      $('.simplebar-content').append('<section class="message -right"><div class="nes-balloon from-right"><p>'+$('#query').val()+'</p></div><image src="/assets/beardbotsmall.png" alt="BB" class="nes-beardbot"></image></section>');
      $(".simplebar-content").scrollTop($(".simplebar-content").prop("scrollHeight"));
      event.preventDefault();
      $.ajax({
        url: '/chat',
        type: 'json',
        method: 'get',
        data: { query: $('#query').val().trim() },
        success: function(data) {
          $('#bot-response').html(data['response']);
          $('.simplebar-content').append('<section class="message -left"><image src="/assets/beardbotsmall.png" alt="BB" class="nes-beardbot"></image><div class="nes-balloon from-left"><p>'+data['response']+'</p></div></section>');
          $('#query').val('');
          $(".simplebar-content").scrollTop($(".simplebar-content").prop("scrollHeight"));
        }
      });
    }
    });
  }

$(document).on('turbolinks:load', ready);
