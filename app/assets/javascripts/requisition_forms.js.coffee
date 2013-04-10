jQuery ->
  $('.requisition-form-form select').removeClass('date').addClass('my-date')
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
      $("#requisition_form_patient_attributes_insurance_policy_id").val(suggestion.data.insurance_policy_id)
      $("#requisition_form_patient_attributes_insurance_date_of_birth_1i").val(suggestion.data.insurance_date_of_birth[0])
      $("#requisition_form_patient_attributes_insurance_date_of_birth_2i").val(suggestion.data.insurance_date_of_birth[1])
      $("#requisition_form_patient_attributes_insurance_date_of_birth_3i").val(suggestion.data.insurance_date_of_birth[2])
      $("#requisition_form_patient_attributes_insurance_relation").val(suggestion.data.insurance_relation)
      $("#requisition_form_patient_attributes_insurance_insured_work_phone").val(suggestion.data.insurance_insured_work_phone)
      $("#requisition_form_patient_attributes_insurance_insured_employer").val(suggestion.data.insurance_insured_employer)
      $("#requisition_form_patient_attributes_insurance_phone").val(suggestion.data.insurance_phone)

      $('.patient-info input,.patient-info select,.insurance-info input,.insurance-info select').attr('disabled','disabled')
      $('.patient-info .clear,.insurance-info .clear').show()

  $('#requisition_form_patient_attributes_first_name,#requisition_form_patient_attributes_middle_name,#requisition_form_patient_attributes_last_name').keydown (e) ->
    $('#requisition_form_patient_attributes_user_id').val('')

  $('.patient-info .clear, .insurance-info .clear').click (e) ->
    $('.patient-info input,.patient-info select,.insurance-info input,.insurance-info select').val('').removeAttr('disabled')
    $('.patient-info .clear,.insurance-info .clear').hide()

  $('#new_requisition_form').submit (e) ->
    $('input,select').removeAttr('disabled')
