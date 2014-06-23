# Hubot classes
Robot = require("hubot/src/robot")
TextMessage = require("hubot/src/message").TextMessage

chai = require 'chai'
mocha = require 'mocha'

{ expect } = chai

describe 'a hubot doing his thing', () ->
  user = null
  robot = null
  beforeEach (done) ->
    robot = new Robot null, 'mock-adapter', yes, 'TestHubot'
    robot.adapter.on 'connected', ->
      require("../angry")(robot)
      # create a user
      user = robot.brain.userForId "1", {
        name: "mocha",
        room: "#mocha"
      }
      done()
    robot.run()

  afterEach (done) ->
    robot.server.close()
    robot.shutdown()
    done()

  it "responds when it hears angry", (done) ->
    robot.adapter.on "send", (envelope, strings) ->
      expect(strings[0]).to.be.a('string')
      done()
    robot.adapter.receive new TextMessage(user, "I am ANGRY")

  it "responds when it hears boos", (done) ->
    robot.adapter.on "send", (envelope, strings) ->
      expect(strings[0]).to.be.a('string')
      done()
    robot.adapter.receive new TextMessage(user, "Beestenbos is boos")

  it "responds when asked for an animal lod", (done) ->
    robot.adapter.on "send", (envelope, strings) ->
      expect(strings[0]).to.be.a('string')
      done()
    robot.adapter.receive new TextMessage(user, "animal lod me!")
