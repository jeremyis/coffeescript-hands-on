class RedditEntry
  constructor: (options) ->
    @title = null
    @data = null
    @url = null

  getEntryObject: (resultChild) ->
    return {}

  isValid: -> return false

exports.RedditEntry = RedditEntry
