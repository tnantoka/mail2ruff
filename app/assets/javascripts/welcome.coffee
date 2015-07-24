$ ->

$(document).on 'click', '.js-show-form-page-id', (e) ->
  e.preventDefault()
  $this = $(this)
  $container = $this.parents('.js-container-page-id')

  $this.html('<i class="fa fa-spinner fa-pulse"></i>')

  team = $this.data('team')
  note = $this.data('note')
  pageId = $this.data('page-id')

  $.get "/pages?team=#{team}&note=#{note}", (data) ->
    $select = $container.find('.js-select-page-id')
    for page in data.pages
      $select.append("<option value=\"#{page.id}\">#{page.title}</option>")

    $container.find('.js-content-page-id').show()
    $container.find('.js-form-page-id').show()
    $select.select2()
    $select.select2('val', pageId)

    $this.remove()

$(document).on 'submit', '.js-form-page-id', (e) ->
  e.preventDefault()
  $this = $(this)
  $container = $this.parents('.js-container-page-id')

  $form = $container.find('.js-form-page-id')
  $link = $container.find('.js-link-page-id')

  params = $form.serialize()
  action = $form.prop('action')
  $.post action, params, (data) ->
    $link.prop('href', data.page_url)
    $link.text(data.page_path)

