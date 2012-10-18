express = require 'express'
gimages = require 'google-images'

app = express()

# Some syntax hints:
# * The last line in a function is implicitly returned.
# * Commas are not required on multiline arrays.
# * If you don't recognize a syntax, go to http://coffeescript.org/
# * Also check out the "Try Coffeescript" link on that site to see compilation
#   to JavaScript.

DEFAULT_SUBREDDIT = 'cabinporn'
sponsoredSubreddits = [
    DEFAULT_SUBREDDIT
    'funny'
    'programming'
    'ama'
    'bestof'
  ]

getEntryHtml = (entry) ->
  """
  <li>
    <img src='#{entry}' />
  </li>
  """

# Add a splat here with 'sponsored links'
getSimplifiedEntriesHtml = (entries, image) ->
  entryArray = []
  entryArray.push getEntryHtml entry for entry in entries
  """
  <html>
    <body>
      <h2>Hands On <s>Reddit</s> Google Images Browser!</h2>
      <h4>You searched for #{image}</h4>
      <form action="/" method="GET">
        <span>Search for anything!</span>
        <input type='text' name='image' />
        <input type='submit' />
        </form>
      <ol>
        #{entryArray.join "\n"}
      </ol>
    </body>
  </html>
  """

entryIsValid = (e) -> e.title? and e.url? and e.score?

# Validate entries, and if valid, return the correct response code
getResponseCode = (simplifiedEntries) ->
  entriesAreOk = [true for e in simplifiedEntries when entryIsValid(e)].length > 0
  if entriesAreOk then 200 else 500

makeEntry = (resultChild) ->
  {unescapedUrl} = resultChild
  unescapedUrl

respond = (image, res) ->
  gimages.search image, (err, results) ->
    entries = results
    if not entries?
      console.error results
      return res.send "Something went wrong! Check yo logs."
    simplifiedEntries = (makeEntry(r) for r in entries)
    console.log simplifiedEntries
    html = getSimplifiedEntriesHtml simplifiedEntries, image
    # (PROBLEM 3) Replace 200 below with an appropriate call to
    # getResponseCode. Make sure the site still loads. Hint: if the page isn't
    # loading try compiling the code after you write it (using coffeescript.org)
    res.send 200, html

# app.get '/', (req, res) ->
#   {image} = req.params
#   respond image, res

app.get '/', (req, res) ->
  respond req.query?.image, res

app.listen 3000
console.log 'Listening on port 3000. Browse to http://127.0.0.1:3000/'