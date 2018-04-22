$(document).on 'turbolinks:load', ->
  $('.pagination a').attr('data-remote', 'true');
  @close_popup = ->
    document.getElementById('quick_view_popup-overlay').style.display = 'none'
    document.getElementById('quick_view_popup-wrap').style.display = 'none'
  $('#product_picture').bind 'change', ->
    size_in_megabytes = this.files[0].size/1024/1024
    if (size_in_megabytes > 5)
      alert('Maximum file size is 5MB. Please choose a smaller file.')
