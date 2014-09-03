class App.Models.Form
  constructor: (object) ->
    @$form = object.form
    @data = object.data
    str = ''

    if @$form.closest('.pop-up').is('#call_form')
      subject = 'форма (связаться с организатором) с сайта praktikadays.ru'
    else if @$form.closest('.pop-up').is('#partner_form')
      subject = 'форма (стать партнером) с сайта praktikadays.ru'

    for key, value of @data
      str += key + ": " + value + "\r\n"

    $.get 'php/sender.php', {data: str, subject: subject}, (message) =>
      if message is 0
        alert 'Ошибка на сервере! Попробуйте заполнить еще раз'
      else
        @$form.trigger('reset')
        @$form.parent().find('.close-pop-up').trigger('click')
        alert 'Ваш запрос успешно отправлен'
