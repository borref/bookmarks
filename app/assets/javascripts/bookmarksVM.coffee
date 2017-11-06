class @BookmarksVM
  constructor: ->
    @title = ko.observable()
    @url = ko.observable()
    @shortening = ko.observable('')
    @bookmarksList = ko.observableArray()

  save: ->
    if @title() and @url()
      bookmark = { title: @title(), url: @url(), shortening: @shortening() }

      api.bookmarks.post(bookmark).then (response) =>
        @bookmarksList.push(response)

  edit: ->
    console.log @

