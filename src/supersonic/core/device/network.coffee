Promise = require 'bluebird'

{network} = require '../events'

module.exports = (steroids, log) ->
  bug = log.debuggable "supersonic.device.network"

  ###
   # @namespace supersonic.device
   # @name network
   # @overview
   # @description
   # Provides information about the network status of the device.
  ###
  ###
   # @namespace supersonic.device.network
   # @name whenOffline
   # @function
   # @apiCall supersonic.device.network.whenOffline
   # @description
   # Detect when device goes offline
   # @type
   # supersonic.device.network.whenOffline: () => unsubscribe: Function
   # @define {Function} unsubscribe Stop listening
   # @exampleCoffeeScript
   # supersonic.device.network.whenOffline().then ->
   #   supersonic.logger.log("Device is offline")
   # @exampleJavaScript
   # supersonic.device.network.whenOffline().then( function() {
   #   supersonic.logger.log("Device is offline");
   # });
  ###
  whenOffline: (f)->
    whenOffline = null
    network
      .map((status) ->
        if status
          ->
            whenOffline?()
            whenOffline = null
        else
          ->
            whenOffline = f()

      )
      .onValue (notify) ->
        setTimeout notify, 0

  ###
   # @namespace supersonic.device.network
   # @name whenOnline
   # @function
   # @apiCall supersonic.device.network.whenOnline
   # @description
   # Detect when device goes online
   # @type
   # supersonic.device.network.whenOnline: () => unsubscribe: Function
   # @define {Function} unsubscribe Stop listening
   # @exampleCoffeeScript
   # supersonic.device.network.whenOnline().then ->
   #   supersonic.logger.log("Device is online")
   # @exampleJavaScript
   # supersonic.device.network.whenOnline().then( function() {
   #   supersonic.logger.log("Device is online");
   # });
  ###
  whenOnline: (f)->
    whenOnline = null
    network
      .map((status) ->
        if status
          ->
            whenOnline = f()
        else
          ->
            whenOnline?()
            whenOnline = null
      )
      .onValue (notify) ->
        setTimeout notify, 0
