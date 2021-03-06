{% assign method = include.method %}
{% assign instance_name = method.name | split: '-' %}
## API Reference: {{instance_name.first}}

{{method.description}}

{% if method.exampleCoffeeScript || method.exampleJavaScript %}

<div class="clearfix">
  <div class="btn-group btn-group-xs pull-right" role="group" style="margin-top: 20px;">
    <button type="button" data-role="type-switch" data-type="js" class="btn btn-primary active">JavaScript</button>
    <button type="button" data-role="type-switch" data-type="coffee" class="btn btn-default">CoffeeScript</button>
  </div>
  <h3>Example usage</h3>
</div>

<div data-role="example-code" data-type="js">

{% if method.exampleJavaScript %}
{% highlight javascript %}
{{method.exampleJavaScript}}
{% endhighlight %}
{% endif %}

{% if !method.exampleJavaScript && method.usageJavaScript %}
{% highlight javascript %}
{{method.usageJavaScript}}
{% endhighlight %}
{% endif %}

</div>

<div data-role="example-code" data-type="coffee" style="display: none;">

{% if method.exampleCoffeeScript %}
{% highlight coffeescript %}
{{method.exampleCoffeeScript}}
{% endhighlight %}
{% endif %}

{% if !method.exampleCoffeeScript && method.usageCoffeeScript %}
{% highlight coffeescript %}
{{method.usageCoffeeScript}}
{% endhighlight %}
{% endif %}

</div>

{% endif %}

{% if method.params.size > 0 %}
#### Params

{% if method.type %}
```coffeescript
{{method.type}}
```
{% endif %}

<table class="table" style="margin:0;">
  <thead>
    <tr>
      <th>Name</th>
      <th>Type</th>
      <th>Default</th>
      <th>Details</th>
    </tr>
  </thead>
  <tbody>
  {% for param in method.params %}
  <tr>
    <td class="highlight">
      <code class="language-coffeescript" data-lang="coffeescript">
        {{param.name}}
      </code>
    </td>
    <td class="highlight">
      <code class="language-coffeescript" data-lang="coffeescript">
      {{param.type | xml_escape}}
      </code>
    </td>
    {% if param.defaultValue %}
    <td class="highlight">
      <code class="language-coffeescript" data-lang="coffeescript">
      {{param.defaultValue}}
      </code>
    </td>
    {% endif %}
    {% if param.defaultValue == undefined %}
    <td>
    </td>
    {% endif %}
    <td>{{param.description | markdownify}}</td>
  </tr>
    {% for property in param.properties %}
      <tr>
        <td class="property">
          <code class="language-coffeescript" data-lang="coffeescript">
            {{property.name}}
          </code>
        </td>
        <td class="highlight">
          <code class="language-coffeescript" data-lang="coffeescript">
          {{property.type | xml_escape}}
          </code>
        </td>
        {% if property.defaultValue %}
        <td class="highlight">
          <code class="language-coffeescript" data-lang="coffeescript">
          {{property.defaultValue}}
          </code>
        </td>
        {% endif %}
        {% if property.defaultValue == undefined %}
        <td>
        </td>
        {% endif %}
        <td>{{property.description | markdownify}}</td>
      </tr>
    {% endfor %}
  {% endfor %}
  </tbody>
</table>
{% endif %}


{% if method.returnsDescription %}
#### Returns
{{ method.returnsDescription | markdownify }}

{% if method.returns.size > 0 %}
<table class="table" style="margin:0;">
  <thead>
    <tr>
      <th>Name</th>
      <th>Type</th>
      <th>Details</th>
    </tr>
  </thead>
  <tbody>
  {% for return in method.returns %}
    <tr>
      <td class="highlight">
        <code class="language-coffeescript" data-lang="coffeescript">
          {{return.name}}
        </code>
      </td>
      <td class="highlight">
        <code class="language-coffeescript" data-lang="coffeescript">
        {{return.type | xml_escape}}
        </code>
      </td>
      <td>{{return.description | markdownify}}</td>
    </tr>
    {% for property in return.properties %}
      <tr>
        <td class="property">{{property.name}}</td>
        <td class="highlight">
          <code class="language-coffeescript" data-lang="coffeescript">
          {{property.type | xml_escape}}
          </code>
        </td>
        <td>{{property.description | markdownify}}</td>
      </tr>
    {% endfor %}
  {% endfor %}
  </tbody>
</table>
{% endif %}
{% endif %}
