jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      # Bail out right away if we're busy loading the next chunk.
      return if(window.pagination_loading)
      url = $('.pagination .next_page').attr('href')
      if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 50
        # Make a note that we're busy loading the next chunk.
        window.pagination_loading = true
        # Load as before but attach a callback to clear the flag when we're done.
        $('.pagination').text('Fetching more products...')
        $.getScript(url).always -> window.pagination_loading = false
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

client = new ZeroClipboard($(".copy-button"))

