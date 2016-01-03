$.fn.editable.defaults.mode = 'inline'
$ ->
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


  $('#enable').click ->
    $('#files .editable').editable('toggleDisabled')
