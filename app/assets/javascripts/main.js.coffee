$.fn.editable.defaults.mode = 'inline'
$(document).on 'ready page:load',  ->
  # datatable
  $('#files').dataTable
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#files').data('source')
    language:
      url: "//cdn.datatables.net/plug-ins/3cfcc339e89/i18n/Japanese.json"
    aoColumns: [
      null,
      null,
      null,
      null,
      null,
      {bSortable: false},
      {bSortable: false}
    ]
    fnDrawCallback: ->
      # materilize select
      $('select').material_select()

  # jquery fileupload
  $('#document_file').fileupload
    add: (e, data) ->
      data.context = $('<div><button>Start</button></div>').prepend('Upload')
        .appendTo('#listing_upload')
        .click ->
          data.context = $(tmpl("template-upload", data.files[0]))
          $(@).replaceWith(data.context)
          data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    done: (e, data) ->
      $(data.context).html('Done!')
        .fadeOut("slow")
      $('#files').dataTable().api().ajax.reload()

  # x editable
  $('#enable').click ->
    $('#files .editable').editable('toggleDisabled')

  # select2
  $('#binder').select2
    width: 400
    ajax:
      url: '/binder/source.json'
      dataType: 'json'
      delay: 250
      data: (params) ->
        console.log params
        q: params.term
      processResults: (data, params) ->
        console.log data
        console.log params
        results: $.map(data, (obj)->
          id: obj.id
          text: obj.title
        )

  # select2 move 
  $('#binder').on "change", (e) ->
    id = $(@).val()
    unless id
      window.location.href = '/'
    else
      location.href = '/binder/' + id

  # binder create form dialog
  $('#create_binder').click (e) ->
    e.preventDefault()
    $('#binder_create_form').dialog
      title: 'Create Binder'

  # binder destroy form dialog
  $('#destroy_binder').click (e) ->
    e.preventDefault()
    $('#binder_destroy_form').dialog
      title: 'Destroy Binder'

