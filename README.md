For the hands-on part of the talk, we're going to be sprucing up a Reddit
subreddit browser I made earlier (building off github.com/timisbusy's previous
Node Hands On module).

(PROBLEM 1)
  Run "npm install" and then "node app.js".
  Navigate to http://127.0.0.1:3000  and confirm the subreddit browser works.

(PROBLEM 2)
  Familarize yourself with the `_app.coffee` code. If you've never worked with
  CoffeeScript before, it'll likely be a little foreign.  Check out the hints at
  the top of the file. There is definitely coffee syntax the talk did not go over
  so definitely check out http://www.coffeescript.org/ (and don't hesitate to
  ask).

(PROBLEM 3)
  OK. Let's make some code changes. Search for `(PROBLEM 3)` in `_app.coffee`.
  It should be around line 77.

(PROBLEM 4)
  OK, let's check out some object orientedness. Open up redditEntry.coffee,
  which has a skeleton class. Fill in the constructor and methods (getEntryObject,
  isValid) and then plug this in to `_app.coffee`. Don't forget to require()
  the file from `_app.coffee`.

  Note: after this problem, the following should be replaced with calls to the
  class:
    # getResponseCode's subfunction entryIsValid
    # makeEntry and calls to it

(PROBLEM 5)
