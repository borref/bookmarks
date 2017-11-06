class @BookmarksVM
  constructor: ->
    @title = ko.observable()
    @url = ko.observable()
    @shortening = ko.observable('')
    @shouldBeFocused = ko.observable(true)
    @bookmarksList = ko.observableArray()
    @currentBookmark = null

  save: ->
    if @title() and @url()
      bookmark = { title: @title(), url: @url(), shortening: @shortening() }

      if @currentBookmark
        api.bookmarks(@currentBookmark.id).put(bookmark).then (response) =>
          @bookmarksList.push(response)
          @currentBookmark = null
      else
        api.bookmarks.post(bookmark).then (response) =>
          @bookmarksList.push(response)

  edit: (bookmark) =>
    @currentBookmark = bookmark

    @title(@currentBookmark.title)
    @url(@currentBookmark.url)
    @shortening(@currentBookmark.shortening)
    @shouldBeFocused(true)

