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
//= require Chart.bundle
//= require chartkick

var ready;
var showText;
var talking = false;

showText = function (target, message, index, interval) {
  if (index < message.length) {
    if (!talking){
      $('#beardbot-avatar-img').attr('src', image_path('beardbottalking.gif'));
    }
    talking = true;
    $(target).append(message[index++]);
    setTimeout(function () { showText(target, message, index, interval); }, interval);
  }
  else{
    $('#beardbot-avatar-img').attr('src', image_path('beardbot.png'));
    talking = false;
  }
}

ready = function(){
  $('#talk').on('click', function(event) {
    if ($('#query').val().trim() != ""){
      var yourMessage = $('#query').val().trim();
      event.preventDefault();
      $('#talk').prop('disabled', true);
      $('#talk').addClass('is-disabled');
      $('.simplebar-content').append('<section class="message -right"><div class="nes-balloon from-right"><p>'+$('#query').val()+'</p></div><image src="'+image_path('you.png')+'" alt="BB" class="nes-beardbot"></image></section>');
      $(".simplebar-content").scrollTop($(".simplebar-content").prop("scrollHeight"));
      $('#query').val('');
      $.ajax({
        url: '/msg',
        type: 'json',
        method: 'post',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        data: { text: yourMessage, is_beardbot: false },
        success: function(data) {
          $.ajax({
            url: '/chat',
            type: 'json',
            method: 'get',
            data: { query: yourMessage },
            success: function(data) {
              var reply = data['response']
              $.ajax({
                url: '/msg',
                type: 'json',
                method: 'post',
                beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                data: { text: reply, is_beardbot: true },
                success: function(data) {
                  $('#bot-response').html('');
                  currentReply = reply;
                  showText("#bot-response", reply, 0, 40);
                  $('#talk').prop('disabled', false);
                  $('#talk').removeClass('is-disabled');
                  $('.simplebar-content').append('<section class="message -left"><image src="'+image_path('beardbotsmall.png')+'" alt="BB" class="nes-beardbot"></image><div class="nes-balloon from-left"><p>'+reply+'</p></div></section>');
                  $(".simplebar-content").scrollTop($(".simplebar-content").prop("scrollHeight"));
                }
              });
            }
          });
        }
      });
    }
    });

    $('.convo-listitem').on('click', function(event) {
      event.preventDefault();
      $('#convo-title').html($(this).html());
      $('.message-history-list').find('.simplebar-content').html('');
      $.ajax({
          url: '/history',
          type: 'json',
          method: 'get',
          data: { conversation_id: this.id },
          success: function(data) {
            var list = '';
            for (var i = 0; i < data['response'].length; i++){
              if (data['response'][i].is_beardbot){
                list += '<p style="margin-right: 30px;">BEARDBOT: '+data['response'][i].text+'</p>';
              }else{
                list += '<p style="margin-right: 30px;">USER: '+data['response'][i].text+'</p>';
              }
            }
            $('.message-history-list').find('.simplebar-content').append(list);
        }
      });
    });
  }

$(document).on('turbolinks:load', ready);
