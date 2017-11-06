# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener 'turbolinks:load', ->
  viewModel = new BookmarksVM
  ko.applyBindings viewModel

  # Retrieve stored bookmarks
  api.bookmarks.get().then (bookmarks) ->
    viewModel.bookmarksList(bookmarks)
