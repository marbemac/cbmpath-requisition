jQuery ->
  $('.medical-history-field .med-check').change (e) ->
    self = e.target
    if $(self).is(':checked')
      $(self).siblings('.optional').children('input').removeAttr('disabled')
    else
      $(self).siblings('.optional').children('input').attr('disabled','disabled')

  # Couldn't get it to work for .rule-out
  $('.medical-history-field .rule-out-check').change (e) ->
    self = e.target
    if $(self).is(':checked')
      $(self).siblings('.rule-out').find('input').removeAttr('disabled')
    else
      $(self).siblings('.rule-out').find('input').attr('disabled','disabled')

  #  NOTE: Didn't work for this nested one, so made a special case
  $('.medical-history-field .cancer-check').change (e) ->
    self = e.target
    if $(self).is(':checked')
      $(self).next('.optional').children('input').removeAttr('disabled')
    else
      $(self).next('.optional').children('input').attr('disabled','disabled')
