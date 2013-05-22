describe "dom plugin", ->

  before ->
    @scaleApp = window.scaleApp
    @plugin   = @scaleApp.plugins.dom
    @core     = new @scaleApp.Core
    @core.use(@plugin).boot()

    # helper method
    @run = (fn, opt={}) =>

        # create module
        mod = (sb) ->
          init: -> fn sb
          destroy: ->

        # register module
        @core.register "myId", mod

        # start that moudle
        @core.start "myId", options: opt

    @dummy = { a: "dummy" }

  it "installs itself to the sandbox", (done) ->

    @run (sb) ->
      (expect typeof sb.getContainer).toEqual "function"
      done()

  it "returns the object that was defined in the option object", (done) ->
    test = (sb) =>
      (expect sb.getContainer()).toBe @dummy
      done()
    @run test, container: @dummy

  it "returns the dom object which id was defined in the option object", (done) ->

    div = window.document.createElement "div"
    div.setAttribute "id", "dummy"
    window.document.body.appendChild div

    test = (sb) ->
      (expect sb.getContainer()).toBe div
      done()

    @run test, container: "dummy"
