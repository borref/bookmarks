class @BookmarksVM
  constructor: ->
    @title = ko.observable()
    @url = ko.observable()
    @shortening = ko.observable()
    @bookmarksList = ko.observableArray()

  save: ->
    console.log @title()
    console.log @url()
    if @title() and @url()
      console.log 'sending req'
      bookmark = { title: @title(), url: @url(), shortening: @shortening() }

      api.bookmarks.post(bookmark).then (response) ->
        @bookmarksList.push(response)

  edit: ->
    console.log @

