jQuery ->
  # Check boxes
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


  # Copy ICD-9 fields
  $('.icd9-copy-button').click (e) ->
    parent = $(e.target).closest('.copy-parent')
    parent.find('.copy-me').clone().removeClass('copy-me').val('').insertBefore(parent.find('.before-me')).focus()

  # Copy specimen fields
  $('.specimen-copy-button').click (e) ->
    parent = $(e.target).closest('.copy-parent')
    element = parent.find('.copy-me').clone().removeClass('copy-me').insertBefore(parent.find('.before-me'))
    element.find('input[type=checkbox]').removeAttr('checked')
    element.find('input[type=text]').val('')
    myDate = new Date();
    for input in element.find('input')
      $(input).attr('name', $(input).attr('name').replace(/(.*mens\]\[)(.*)(\]\[.*\])/, "$1#{parseInt(myDate.getTime())}$3"))

  $('#requisition_form_doctor_attributes_name,#requisition_form_doctor2_attributes_name').autocomplete
    serviceUrl: '/search/doctors'
    minChars: 3
    deferRequestBy: 50
    noCache: false
    onSelect: (suggestion) ->
      $(@).parent().next().find('input').val(suggestion.data.id)
  $('#requisition_form_doctor_attributes_name,#requisition_form_doctor2_attributes_name').keydown (e) ->
    $(@).parent().next().find('input').val('')
