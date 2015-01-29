if condition on empty string
{% if my_variable == blank %}
I'm not empty
{% endif %}

{% if my_variable.blank? %}
I'm not empty
{% endif %}

if condition and assing value to any variables
{% if (collection.sort_by == 'manual' or collection.sort_by == 'best-selling' or collection.sort_by == 'title-ascending' or collection.sort_by == 'title-descending' or collection.sort_by == 'price-ascending' or collection.sort_by == 'price-descending' or collection.sort_by == 'created-descending' or collection.sort_by == 'created-ascending') %}
  		{% assign my_variable = 5 %}
  {% else %}
  		{% assign my_variable = collection.sort_by %}
   {% endif %}

  {% if collection.sort_by == blank %}
     {% assign my_variable = 5 %}
  {% endif %}

{% paginate collection.products by my_variable %}
{% endpaginate %}


Add custom filter in to the shopify application and moved the codes to Dev.

Download sample themes and customized. Add custom filter in to the shopify application and moved the codes to Dev.