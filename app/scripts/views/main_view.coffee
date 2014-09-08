class App.Views.MainView
  MOVING_DURATION = 1500
  LIST_LENGTH = 3
  HEIGHT = 0
  SHORT_HEIGHT = 0
  MARGIN_BOTTOM = 40
  DATE = [2014, 10, 4]

  constructor: ->
    @initUi()
    @events()
    @_initReviewList()
    @_setDate()
    @_detectBrowser()
    @_initPhotoalbum()

  initUi: ->
    @ui =
      wind: $(window)
      body: $('body, html')
      onlyBody: $('body')
      header: $('.header')
      popupForm: $('.pop-up form')
      callForm: $('#call_form')
      partnerForm: $('#partner_form')
      scrollButton: $('.scroll-button')
      scrollScreen: $('.scroll-screen')
      presentersButton: $('.presenters-button')
      presentersScreen: $('.presenters-screen')
      mapButton: $('.map-button')
      mapScreen: $('.map-screen')
      aboutButton: $('.about-button')
      aboutScreen: $('.about-screen')
      popupButton: $('.pop-up-button')
      closeButton: $('.close-pop-up')
      regButton: $('.reg-button')
      regScreen: $('.registration-screen')
      reviewShowButton: $('#show_list_button')
      reviewList: $('#review_list')
      reviewListItem: $('#review_list li')
      daysCount: $('.days-count')
      photoalbum: $('#photoalbum')
      photo: $('.photo')
      img: $('.photo img')

  events: ->
    @ui.wind.on 'scroll', @onScroll
    @ui.regButton.on 'click', (=> @moveToElement(@ui.regScreen, 0))
    @ui.aboutButton.on 'click', (=> @moveToElement(@ui.aboutScreen, 0))
    @ui.presentersButton.on 'click', (=> @moveToElement(@ui.presentersScreen, 0))
    @ui.scrollButton.on 'click', (=> @moveToElement(@ui.scrollScreen, 0))
    @ui.mapButton.on 'click', (=> @moveToElement(@ui.mapScreen, 0))
    @ui.reviewShowButton.on 'click', @showReviews
    @ui.popupForm.on 'submit', @submitForm
    @ui.popupButton.on 'click', @showPopUp
    @ui.closeButton.on 'click', @closePopUp

  moveToElement: (element, height) ->
    @ui.body.animate(scrollTop: @_getFromTop(element, height), MOVING_DURATION, 'easeInOutCirc')

  onScroll: =>
    if @ui.wind.scrollTop() < 80
      @ui.header.addClass('transparent')
    else
      @ui.header.removeClass('transparent')

  showReviews: =>
    @ui.reviewShowButton.toggleClass('active')

    if @ui.reviewShowButton.hasClass('active')
      @ui.reviewShowButton.html('Скрыть все отзывы')
      @ui.reviewList.animate(height: HEIGHT, 700)
    else
      @ui.reviewShowButton.html('Раскрыть все отзывы')
      @ui.reviewList.animate(height: SHORT_HEIGHT, 700)

  showPopUp: (event) =>
    self = $(event.currentTarget)
    @ui.body.addClass('fixed')

    if self.is('#call_button')
      @ui.callForm.addClass('show')
    else if self.is('#partner_button')
      @ui.partnerForm.addClass('show')

  closePopUp: =>
    @ui.callForm.removeClass('show')
    @ui.partnerForm.removeClass('show')
    @ui.body.removeClass('fixed')

  submitForm: (event) ->
    event.preventDefault()
    self = $(event.currentTarget)
    $input = self.find('.field input')
    flag = true
    data = {}

    $input.each ->
      flag = false if $(@).val() is ''

    if flag
      $input.each ->
        inp = $(@)
        data[inp.attr('name')] = inp.val()
      new App.Models.Form(form: self, data: data)
    else
      alert('Пожалуйста заполните все поля!')

  _getFromTop: (element, height) ->
    element.offset().top + height

  _setDate: ->
    targetDate = moment(DATE)
    today = moment().format()
    daysCount = targetDate.diff(today, 'days')
    lastChar = daysCount.toString().slice(-1)

    if daysCount <= 0
      daysCount = 0
      text = 'Дней'
    else
      if lastChar is '1'
        text = 'День'
      else if lastChar is '2' or lastChar is '3' or lastChar is '4'
        text = 'Дня'
      else
        text = 'Дней'

    @ui.daysCount.find('.day').html(daysCount)
    @ui.daysCount.find('.day-text').html(text)

  _initReviewList: ->
    itter = 1

    @ui.reviewListItem.each ->
      HEIGHT += $(@).height() + MARGIN_BOTTOM
      SHORT_HEIGHT = HEIGHT if itter is LIST_LENGTH
      itter++

    @ui.reviewList.height(SHORT_HEIGHT)

  _initPhotoalbum: ->
    @ui.photo.each ->
      $(@).prepend(
        """
          <div class=p-box>
            <p>
              Отмечайте себя и смотрите<br>комментарии ко всем фотографиям<br>в нашем альбоме в Facebook
            </p>
            <a href='' class=button>
              Посмотреть все фото
              <i class="fa fa-arrow-right fa-red"></i>
            </a>
          </div>
        """
      )

    @ui.photoalbum.imagesReady =>
      shift = 0

      @ui.photoalbum.find('.p-box').each ->
        self = $(@)
        width = self.parent().find('img').width()
        self.css
          width: width
          left: shift
        shift += width

      @ui.photoalbum.smoothTouchScroll()

      @ui.photoalbum.find('.scrollableArea').width(shift)

  _detectBrowser: ->
    if $.browser.mozilla
      if @_osDetection() isnt 'MacOS'
        @ui.onlyBody.addClass('mozilla')

  _osDetection: ->
    OSName = undefined

    if (navigator.appVersion.indexOf('Win') isnt -1) then OSName = 'Windows'
    if (navigator.appVersion.indexOf('Mac') isnt -1) then OSName = 'MacOS'
    if (navigator.appVersion.indexOf('X11') isnt -1) then OSName = 'UNIX'
    if (navigator.appVersion.indexOf('Linux') isnt -1) then OSName = 'Linux'

    OSName
