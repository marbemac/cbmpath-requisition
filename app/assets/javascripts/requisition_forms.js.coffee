jQuery ->
  $number = 1

  $('.requisition-form-form select.date').removeClass('date').addClass('my-date') # So the validator doesnt require a date string from each date select.
  $('.requisition-form-form').validate({
                                        groups: {
                                          collection_date: ["requisition_form[collection_date(1i)]",
                                                            "requisition_form[collection_date(2i)]",
                                                            "requisition_form[collection_date(3i)]"]
                                          dob_1: ["requisition_form[patient_attributes][date_of_birth(1i)]",
                                                  "requisition_form[patient_attributes][date_of_birth(2i)]",
                                                  "requisition_form[patient_attributes][date_of_birth(3i)]"]
                                          dob_2: ["requisition_form[patient_attributes][insurance_date_of_birth(1i)]]",
                                                  "requisition_form[patient_attributes][insurance_date_of_birth(2i)]",
                                                  "requisition_form[patient_attributes][insurance_date_of_birth(3i)]"]
                                        },
                                        errorPlacement: (error, element) ->
                                          if element.hasClass('my-date')
                                            error.insertAfter(element.siblings('.my-date').last())
                                          else
                                            error.insertAfter(element)
                                        })

  # Check boxes
  $('.insurance-info .radio-group input').change (e) ->
    self = '#requisition_form_patient_attributes_insurance_type_insurance'
    if $(self).is(':checked')
      $('.requisition-form-form .if-insured').each () ->
        $(this).addClass('required')
    else
      $('.requisition-form-form .if-insured').each () ->
        $(this).removeClass('required error').addClass('valid')
        $(this).siblings('label.error').remove()

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
      $(self).siblings('.rule-out').find('.optional >label >input').removeAttr('disabled')
    else
      $(self).siblings('.rule-out').find('input').attr('disabled','disabled')

  #
  $('body').on "change", '.specimen-box input[type=radio]', (e) ->
    self = e.target
    $(self).closest('.specimen-grid-row').find('input').removeAttr('disabled')
    $('.specimen-copy-button').removeAttr('disabled')

  #  NOTE: Didn't work for this nested one, so made a special case
  $('.medical-history-field .cancer-check').change (e) ->
    self = e.target
    console.log('foo')
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
    unless $(e.target).attr('disabled')
      parent = $(e.target).closest('.copy-parent')
      value = parent.find('input[type=radio]:checked').attr('value')

      element = parent.find('.copy-me').clone()
      element.removeClass('copy-me').insertBefore(parent.find('.before-me'))
      element.find('input[type=checkbox], input[type=radio]').removeAttr('checked')
      element.find('input[type=text]').val('')
      $number += 1
      element.find('.specimen-first span').text($number)

      parent.find(".copy-me input[value='#{value}']").click()

      myDate = new Date()
      for input in element.find('input')
        $(input).attr('name', $(input).attr('name').replace(/(.*mens\]\[)(.*)(\]\[.*\])/, "$1#{parseInt(myDate.getTime())}$3"))

      $(e.target).attr('disabled', 'disabled') unless $(e.target).hasClass('gyn')


  $('#requisition_form_doctor_attributes_name,#requisition_form_doctor2_attributes_name').autocomplete
    serviceUrl: '/search/doctors'
    minChars: 3
    deferRequestBy: 50
    noCache: false
    onSelect: (suggestion) ->
      $(@).parent().next().find('input').val(suggestion.data.id)
  $('#requisition_form_doctor_attributes_name,#requisition_form_doctor2_attributes_name').keydown (e) ->
    keycode = if e.keyCode then e.keyCode else e.which
    unless keycode == 9 # tab key
      $(@).parent().next().find('input').val('')

  $('#requisition_form_patient_attributes_first_name,#requisition_form_patient_attributes_middle_name,#requisition_form_patient_attributes_last_name').autocomplete
    serviceUrl: '/search/patients'
    minChars: 3
    deferRequestBy: 50
    noCache: false
    onSelect: (suggestion) ->
      $('#requisition_form_patient_attributes_id').val(suggestion.data.id)
      $('#requisition_form_patient_attributes_first_name').val(suggestion.data.first_name)
      $('#requisition_form_patient_attributes_middle_name').val(suggestion.data.middle_name)
      $('#requisition_form_patient_attributes_last_name').val(suggestion.data.last_name)
      $("#requisition_form_patient_attributes_sex_#{suggestion.data.sex}").prop('checked', true)
      $("#requisition_form_patient_attributes_date_of_birth_1i").val(suggestion.data.date_of_birth[0])
      $("#requisition_form_patient_attributes_date_of_birth_2i").val(suggestion.data.date_of_birth[1])
      $("#requisition_form_patient_attributes_date_of_birth_3i").val(suggestion.data.date_of_birth[2])
      $("#requisition_form_patient_attributes_ssn").val(suggestion.data.ssn)
      $("#requisition_form_patient_attributes_address").val(suggestion.data.address)
      $("#requisition_form_patient_attributes_city").val(suggestion.data.city)
      $("#requisition_form_patient_attributes_state").val(suggestion.data.state)
      $("#requisition_form_patient_attributes_zipcode").val(suggestion.data.zipcode)
      $("#requisition_form_patient_attributes_zipcode").val(suggestion.data.zipcode)
      $("#requisition_form_patient_attributes_insurance_type_#{suggestion.data.insurance_type.toLowerCase()}").prop('checked', true)
      $("#requisition_form_patient_attributes_insurance_name").val(suggestion.data.insurance_name)
      $("#requisition_form_patient_attributes_insurance_insured_name").val(suggestion.data.insurance_insured_name)
      $("#requisition_form_patient_attributes_insurance_group_number").val(suggestion.data.insurance_group_number)
      $("#requisition_form_patient_attributes_insurance_policy_number").val(suggestion.data.insurance_policy_number)
      $("#requisition_form_patient_attributes_insurance_date_of_birth_1i").val(suggestion.data.insurance_date_of_birth[0])
      $("#requisition_form_patient_attributes_insurance_date_of_birth_2i").val(suggestion.data.insurance_date_of_birth[1])
      $("#requisition_form_patient_attributes_insurance_date_of_birth_3i").val(suggestion.data.insurance_date_of_birth[2])
      $("#requisition_form_patient_attributes_insurance_relation").val(suggestion.data.insurance_relation)
      $("#requisition_form_patient_attributes_insurance_insured_work_phone").val(suggestion.data.insurance_insured_work_phone)
      $("#requisition_form_patient_attributes_insurance_insured_employer").val(suggestion.data.insurance_insured_employer)
      $("#requisition_form_patient_attributes_insurance_phone").val(suggestion.data.insurance_phone)
      $("#requisition_form_patient_attributes_insurance_address").val(suggestion.data.insurance_insured_address)
      $("#requisition_form_patient_attributes_insurance_city").val(suggestion.data.insurance_insured_city)
      $("#requisition_form_patient_attributes_insurance_state").val(suggestion.data.insurance_insured_state)
      $("#requisition_form_patient_attributes_insurance_zipcode").val(suggestion.data.insurance_insured_zipcode)

      $('.patient-info input,.patient-info select').attr('disabled','disabled')
      $('.patient-info .clear,.insurance-info .clear').show()

  $('#requisition_form_patient_attributes_first_name,#requisition_form_patient_attributes_middle_name,#requisition_form_patient_attributes_last_name').keydown (e) ->
    keycode = if e.keyCode then e.keyCode else e.which
    unless keycode == 9 # tab key
      $('#requisition_form_patient_attributes_id').val('')

  $('.patient-info .clear, .insurance-info .clear').click (e) ->
    $('.patient-info input,.patient-info select,.insurance-info input,.insurance-info select').val('').removeAttr('disabled')
    $('.patient-info .clear,.insurance-info .clear').hide()

  $('#new_requisition_form').submit (e) ->
    $('input,select').removeAttr('disabled')

  $('#requisition_form_patient_attributes_insurance_type_self').click ->
    $('#requisition_form_patient_attributes_insurance_insured_name').val("#{$('#requisition_form_patient_attributes_first_name').val()} #{$('#requisition_form_patient_attributes_last_name').val()}")
    $('#requisition_form_patient_attributes_insurance_date_of_birth_2i').val($('#requisition_form_patient_attributes_date_of_birth_2i').val())
    $('#requisition_form_patient_attributes_insurance_date_of_birth_3i').val($('#requisition_form_patient_attributes_date_of_birth_3i').val())
    $('#requisition_form_patient_attributes_insurance_date_of_birth_1i').val($('#requisition_form_patient_attributes_date_of_birth_1i').val())