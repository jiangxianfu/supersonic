---
layout: docs_first_mile
title: Supersonic Documentation
header_title: Supersonic App Logic and Structure
header_sub_title: Learn the basics of modifying your app structure and logic
section_id: second-mile
subsections:
  - name: Overview
  - name: Styling your app
  - name: Basic Debugging
  - name: Supersonic modules
  - name: App configuration
  - name: App logic in the controller
  - name: Access device hardware
  - name: Allergic to modules and CoffeeScript?
  - name: Done!
---
<section class="ag__docs__content">
<section class="docs-section" id="overview">
## Overview

In the previous section you created some simple functionality for your app just by using Supersonic web components. In this section you will:

 - Learn how to style your app
 - Learn to do some simple debugging
 - Create some simple logic for your app
 - Learn to access the device hardware, namely the camera
 - Learn about what goes on behind the scenes in your app
 - How to access and change that information.

Let's get going!

</section>
<section class="docs-section" id="styling-your-app">

# Styling your app

While the `<body>` content of your views can be styled with regular CSS just like any HTML content, the native UI elements such as the navigation and tab bars can be styled with a special CSS file, which is platform-specific. The files are located in the `app/common/native-styles/` folder. Open up the file name corresponding to the platform you are currently running the app on and find the `navigation-bar` selector. Change the contents to the following:

```css
navigation-bar {
  background-color: #27ae60;
}
```

After saving the document, your navigation bar will update to a nice green color. If you explore the CSS file further, you'll notice some basic selectors have already been laid out for you, feel free to play around with the values and see how they affect the app. For a more in-depth look at native styling, see the [native styles documentation][native-styles].

</section>
<section class="docs-section" id="basic-debugging">
## Basic Debugging

Before adding any real logic, it is important to know how to debug your project. You are bound to make some mistakes when you develop, so learning how to detect them is key to a good development experience. Since we're working with a nearly empty app which has no errors, we won't discover any major problems, but logs can contain a wealth of other information besides errors.

### Logs in Connect Screen

You may have already noticed that the Connect Screen (the browser window from where you scan the app's QR code) contains a few different tabs, accesible from the top right corner of the window. Go to the "Logs" tab. If you've closed the window at some point, you can re-open it by typing `c` in the Steroids Development Server console and pressing Enter. In the logs screen you will see something akin to:

<img class="tutorial-image" src="/img/tutorial/Steroids_connect_logs.png">

In the above snapshot you can see four instances of the same message, each one sent by a different view. You can discern what view is sending a specific message via the "View" column in the logs screen. You can also use the tools at the top of the window to filter messages by message type, view and connected device for more precise tracking of a certain component. Naturally you can also clear the log with the press of a button.

Besides logging system messages and detecting erros, you can explicitly send messages to the Steroids Connect window with `steroids.logger.log("Your message here!")`, which can be extremely useful for tracking your application state when debugging. To read more about logging, head over to the [Logging guide][logging-guide].

### Platform-specific debugging

Debugging via the Connect Screen logs is available on all devices and operating systems. For more in-depth tools (such as network monitoring, JavaScript console, DOM inspector and more), there are platform-specific solutions available. To read about them, check out the links below:

  - [Debugging on iOS][debug-ios]
  - [Debugging on Android][debug-android]
  - [Debugging Best Practices][debug-best-practices]

</section>
<section class="docs-section" id="supersonic-modules">

## Supersonic modules

By default, Supersonic apps are made up of modules, which contain the HTML and script files for a certain portion of your app functionality. Currently, our project has two modules: `common`, which is a shared space for all of our app content, and `example`, which has all the views you see in the example app. We want to add a new feature to our app, so it makes sense to create a new module for it. You can create a new module by running `steroids generate module <module-name>` in your project folder. Let's create a `geolocation` module:

```bash
steroids generate module geolocation
```

Choose if you want the module to be generated with CoffeeScript or JavaScript. You will see that the following module is created for your project:

```bash
app/geolocation
├── index.coffee
├── scripts
│   └── IndexController.js (or .coffee)
└── views
    └── index.html
```

In the module, the basic view and controller are created for you, as well as the `index.coffee` file, which declares the associated Angular module and its dependencies, which in this case is the `common` module.

To learn about the Supersonic app structure and working with a Model-View-Controller architecture, see the [Supersonic App Architecture guide][ss-architecture]. For a rundown of all the project config files, see the [App Config Files guide][ss-config-files].

</section>
<section class="docs-section" id="app-configuration">
## App configuration

Next, you need to attach the new module to the rest of your app's views. Let's replace the second tab with our new module. Supersonic projects have a special `config/` folder where we can define certain presets for our application, including the tabs that will be used. In `config/` there are two files with differing responsibilities:

 - `app.coffee` contains general behaviour settings for your app.
 - `structure.coffee` is used to define the initial configuration of your app's views.

For now, all you need is the `structure.coffee` file. In the file, you will see that a `tabs` property has been set, containing three views, `Index`, `Settings` and `Internet`. Change the tabs property to the following:

```coffee
tabs: [
  {
    title: "Index"
    id: "index"
    location: "example#getting-started"
  }
  {
    title: "Geolocation"
    id: "geolocation"
    location: "geolocation#index"
  }
  {
    title: "Internet"
    id: "internet"
    location: "http://google.com"
  }
]
```

The key change is, the second tab now points to our new `geolocation` module. After the app refreshes on your device, you can check out the second tab to see that it has indeed updated. Note that changing the id of the tab from `settings` to `geolocation` makes the tab icon disappear, as the icon is defined in the native css. You can reshow the icon by modifying `tab-bar-item#settings` to be `tab-bar-item#geolocation` in the `.css` files found in `app/common/native-styles/`.

</section>
<section class="docs-section" id="app-logic-in-the-controller">
## App logic in the controller

With the new module in place, we can add some logic to it. When we generated our new module, an `IndexController.js` or `IndexController.coffee` file (if using CoffeeScript) was generated for us. It contains an empty angular controller by default, but let's add a simple function to the controller (under the "#Controller functionality here" comment). If using CoffeeScript, be aware that CoffeeScript is finicky about indentation, so you have to be careful to indent properly.

<div class="clearfix">
  <div class="btn-group btn-group-xs pull-right" role="group" style="margin-top: 20px;">
    <button type="button" data-role="type-switch" data-type="js" class="btn btn-primary active">JavaScript</button>
    <button type="button" data-role="type-switch" data-type="coffee" class="btn btn-default">CoffeeScript</button>
  </div>
</div>

<div data-role="example-code" data-type="js">
{% highlight javascript %}
angular
  .module('geolocation')
  .controller('IndexController', function($scope, supersonic) {
    // Controller functionality here
    $scope.getPosition = function() {
      supersonic.ui.dialog.alert("Interstellar!");
    };
  });
{% endhighlight %}
</div>

<div data-role="example-code" data-type="coffee" style="display: none;">
{% highlight coffeescript %}
angular
  .module('geolocation')
  .controller 'IndexController', ($scope, supersonic) ->
    # Controller functionality here
    $scope.getPosition = () ->
      supersonic.ui.dialog.alert "Interstellar!"
{% endhighlight %}
</div>

`getPosition` is a simple function that is attached to the Angular `$scope`, which is a special object that acts as a link between the application views and data. By attaching `getPosition` to `$scope`, we are able to reference it in any view that shares the same `$scope` as the `IndexController`.

### Access app logic from your view

Now that we have a basic function defined, we want to provide a way to trigger it. To do so, open up `app/geolocation/views/index.html`, and replace the `<h1>` tag with the following:

```html
<button class="button button-block button-positive" ng-click="getPosition()">Get position</button>
```

This creates a button and attaches the previously created `getPosition` function to it via an `ng-click` handler. `ng-click` is a variation of a basic `onclick` handler that automatically detects and utilises the `$scope` object. Having defined the button and saved the document, your app should refresh and display the new button. If you click it, the alert you defined in `IndexController` will pop up on the screen. Tying together your app views and logic is as simple as that!

</section>
<section class="docs-section" id="access-device-hardware">
## Access device hardware

To actually see the device's location, we need to access the device hardware. Supersonic provides access to a wide range of device APIs such as geolocation and accelerometer, and media APIs such as the microphone and camera. You can also find extended support via plugins, but for now the default geolocation API is enough. Change your controller content to the following:

<div class="clearfix">
  <div class="btn-group btn-group-xs pull-right" role="group" style="margin-top: 20px;">
    <button type="button" data-role="type-switch" data-type="js" class="btn btn-primary active">JavaScript</button>
    <button type="button" data-role="type-switch" data-type="coffee" class="btn btn-default">CoffeeScript</button>
  </div>
</div>

<div data-role="example-code" data-type="js">
{% highlight javascript %}
$scope.position = undefined;

$scope.getPosition = function() {
  supersonic.device.geolocation.getPosition().then( function(position){
    $scope.position = position;
  });
};
{% endhighlight %}
</div>

<div data-role="example-code" data-type="coffee" style="display: none;">
{% highlight coffeescript %}
$scope.position = undefined

$scope.getPosition = () ->
  supersonic.device.geolocation.getPosition().then (position) ->
    $scope.position = position
{% endhighlight %}
</div>

Now when you click the "Get position" -button, the geolocation data is added to the `$scope` object. The last step is to display that data in the geolocation view. To do so, add the following to the `app/geolocation/views/index.html`, under the previously defined `<button>` element:

```html
<ul class="list" ng-show="position">{% raw %}
  <li class="item">Latitude: {{position.coords.latitude}}</li>
  <li class="item">Longitude: {{position.coords.longitude}}</li>
  <li class="item">Time: {{position.timestamp}}</li>{% endraw %}
</ul>
```

Save both files and you'll see that after you click the button, the geolocation data appears below it. Note that the first time you attempt to access geolocation data, the device will prompt for permission to access that information, which in this case you should of course allow.
</section>

<section class="docs-section" id="allergic-to-modules-and-coffeescript">
##Allergic to modules and CoffeeScript?

We strive to make the development experience with Supersonic and Steroids as smooth as possible. Through our collective experience, we have settled on what in our minds are the best development practices. This includes the use of CoffeeScript and AngularJS. Of course you may not agree with us, in which case you are free to utilise any framework you want, or generate your projects and modules with JavaScript.

To work outside the modular app structure, you have two choices.

 - If you want to work with the default Supersonic structure, but need some special files that don't really belong in any module, you can place any assets in the `app/common/assets/` folder. The files in that folder will be copied to the application and accessible via their path relative to the `assets` folder (so e.g. `app/common/assets/views/hello.html` would be `views/hello.html` when accessed within your app).

 - Alternatively, you can choose to create a Single-Page Application when running `steroids create`, which will just install the project dependencies and create a single `www` folder, where you can build your app structure as you desire.

To work with plain JavaScript, you can have `steroids create` create your project with JavaScript files by choosing it during the project creation wizard. For cases where you might need just a tiny snippet of JavaScript (maybe for testing out a code snippet), you can just embed it straight into the CoffeeScript files by surrounding your JavaScript with backticks ( \` ):

```coffeescript
  dolan = `function() {
    alert("Hey dolan!")
  }`
```
</section>

<section class="docs-section" id="done">
## Done!

In this section we learned about the basic tools needed for creating truly excellent applications. You now know:

  - The basic structure of a Supersonic project (created with modules).
  - How to do basic debugging via the Connect Screen.
  - How to style the app's native elements with CSS.
  - How to access device hardware and relay the info onwards.

By now you are able to create a feature-robust offline Supersonic app. The last hurdle is connecting your app to real-life data, something that most apps out there utilise. To learn how to initialise and utilise a data backend for your app, head over to the [Third mile][third-mile] tutorial.
</section>
</section>

[app-coffee]: /supersonic/guides/
[debug-ios]: /tooling/cli/debugging/debugging-on-ios
[debug-android]: /tooling/cli/debugging/debugging-on-android
[debug-best-practices]: /tooling/cli/debugging/best-practices
[device-api]: /supersonic/api-reference
[logging-guide]: /tooling/cli/debugging/logging
[native-styles]: /supersonic/guides/ui/styling-native-components
[ss-architecture]: /supersonic/guides/architecture
[structure-coffee]: /supersonic/guides
[third-mile]: /supersonic/tutorial/third-mile
[ss-config-files]: /supersonic/guides/architecture/app-config-files/
