# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@switchPanel = (panelNum) ->
  switch panelNum
    when 1
      $('#nav2').removeClass 'is-primary'
      $('#nav3').removeClass 'is-primary'
      $('#stats_tab').addClass 'hidden'
      $('#traffic_tab').addClass 'hidden'
      $('#nav1').addClass 'is-primary'
      $('#users_tab').removeClass 'hidden'
    when 2
      $('#nav1').removeClass 'is-primary'
      $('#nav3').removeClass 'is-primary'
      $('#users_tab').addClass 'hidden'
      $('#traffic_tab').addClass 'hidden'
      $('#nav2').addClass 'is-primary'
      $('#stats_tab').removeClass 'hidden'
    when 3
      $('#nav1').removeClass 'is-primary'
      $('#nav2').removeClass 'is-primary'
      $('#users_tab').addClass 'hidden'
      $('#stats_tab').addClass 'hidden'
      $('#nav3').addClass 'is-primary'
      $('#traffic_tab').removeClass 'hidden'
    else
      $('#nav2').removeClass 'is-primary'
      $('#nav3').removeClass 'is-primary'
      $('#stats_tab').addClass 'hidden'
      $('#traffic_tab').addClass 'hidden'
      $('#nav1').addClass 'is-primary'
      $('#users_tab').removeClass 'hidden'
      break
  return
