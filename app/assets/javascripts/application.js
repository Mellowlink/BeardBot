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
      var yourMessage = $('#query').val().trim();
      event.preventDefault();
      $('.simplebar-content').append('<section class="message -right"><div class="nes-balloon from-right"><p>'+$('#query').val()+'</p></div><image src="/assets/beardbotsmall.png" alt="BB" class="nes-beardbot"></image></section>');
      $(".simplebar-content").scrollTop($(".simplebar-content").prop("scrollHeight"));
      $('#query').val('');
      $.ajax({
        url: '/msg',
        type: 'json',
        method: 'post',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        data: { text: yourMessage, sent: new Date().getTime(), is_beardbot: false },
        success: function(data) {
          $.ajax({
            url: '/chat',
            type: 'json',
            method: 'get',
            data: { query: yourMessage },
            success: function(data) {
              //start post to beardbot msg create
                $('#bot-response').html(data['response']);
                $('.simplebar-content').append('<section class="message -left"><image src="/assets/beardbotsmall.png" alt="BB" class="nes-beardbot"></image><div class="nes-balloon from-left"><p>'+data['response']+'</p></div></section>');
                $(".simplebar-content").scrollTop($(".simplebar-content").prop("scrollHeight"));
              //end post to user msg create
            }
          });
        }
      });
    }
    });
  }

$(document).on('turbolinks:load', ready);
