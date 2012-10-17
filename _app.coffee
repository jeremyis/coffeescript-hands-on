express = require 'express'
Reddit = require 'handson-reddit'

app = express()
reddit = new Reddit()

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

getSubredditFilterUrl = (subreddit) -> "<a href=\"/#{subreddit}\">#{subreddit}</a>"

getLinkHeader= ->
  ("<b>#{getSubredditFilterUrl sub}</b>" for sub in sponsoredSubreddits).join(' | ')

getEntryHtml = (entry) ->
  {title, url, score} = entry
  """
  <li>
    <a href="#{url}" target="_BLANK">#{title}</a>
  </li>
  """

# Add a splat here with 'sponsored links'
getSimplifiedEntriesHtml = (entries, subreddit) ->
  entryArray = []
  entryArray.push getEntryHtml entry for entry in entries
  """
  <html>
    <body>
      <h2>Hands On Reddit Browser!</h2>
      <h4>You are browsing #{subreddit}</h4>
      #{getLinkHeader()}
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
  {data: {title, url, score}} = resultChild
  {title, url, score}

app.get '/', (req, res) -> res.redirect "/#{DEFAULT_SUBREDDIT}"
app.get '/:subreddit', (req, res) ->
  {subreddit} = req.params

  # reddit.r requests the top 25 links from the provided subreddit.
  reddit.r subreddit, (err, results) ->
    entries = JSON.parse(results?.body)?.data?.children
    if not entries?
      console.error results
      return res.send "Something went wrong! Check yo logs."

    simplifiedEntries = (makeEntry(r) for r in entries)
    html = getSimplifiedEntriesHtml simplifiedEntries, subreddit

    # (PROBLEM 3) Replace 200 below with an appropriate call to
    # getResponseCode. Make sure the site still loads. Hint: if the page isn't
    # loading try compiling the code after you write it (using coffeescript.org)
    res.send 200, html

app.listen 3000
console.log 'Listening on port 3000. Browse to http://127.0.0.1:3000/'
