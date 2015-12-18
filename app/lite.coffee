load = (name, path, apikey, done) ->
  fullPath = "#{path}/#{name}"
  fullPath += "?key=#{apikey}" if apikey?

  if /\.js$/.test name
    el = document.createElement("script")
    el.setAttribute("type", "text/javascript")
    el.setAttribute("src", fullPath)

  else if /\.css$/.test name
    fullPath = fullPath.replace /^\//, ''
    el = document.createElement("link")
    el.setAttribute("rel", "stylesheet")
    el.setAttribute("type", "text/css")
    el.setAttribute("href", fullPath)

  el.addEventListener "load", done
  document.getElementsByTagName("head")[0].appendChild(el)

Lite =
  initialize: (apikey) ->
    from = if apikey then "https://thomaslite.edapp.com/" else ""
    files = [
      "css/app.css"
      "js/vendor.js"
      "js/app.js"
    ]

    do next = ->
      if files.length
        new (require "lib/logger")(true, "thomas", "#46b4e9") JSON.stringify(files)
        file = files.shift()
        load file, from, apikey, next
      else
        new (require "lib/logger")(true, "thomas", "#46b4e9") "Hello!"
        require("app").initialize()

module.exports = Lite
