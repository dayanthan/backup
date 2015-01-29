<script>
  var tt = document.URL;
  function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}
  
var pgId = getParameterByName('pg');

// alert(pgId);
  
</script>
<div>
   {{collection.sort_by}}-----1
   {{blog.url}}-----2
   {{collection.url}}-----3
   {{product.sort_by}}-----4


</div>
{% include 'breadcrumb' %}

{% assign has_sidebar = false %}
{% if collection.all_tags.size > 0 %}
  {% assign has_sidebar = true %}
{% endif %}

<div class="grid grid-border">

  {% if has_sidebar %}
  <aside class="sidebar grid-item large--one-fifth collection-filters" id="collectionFilters">
    {% include 'collection-sidebar' %}
  </aside>
  {% endif %}
  
  {% if (collection.sort_by == 'manual' or collection.sort_by == 'best-selling' or collection.sort_by == 'title-ascending' or collection.sort_by == 'title-descending' or collection.sort_by == 'price-ascending' or collection.sort_by == 'price-descending' or collection.sort_by == 'created-descending' or collection.sort_by == 'created-ascending') %}
  		{% assign my_variable = 5 %}
  {% else %}
  		{% assign my_variable = collection.sort_by %}
   {% endif %}
  {% if collection.sort_by == blank %}
  {% assign my_variable = 5 %}
  {% endif %}

  
  {% paginate collection.products by my_variable %}
  
  <div class="grid-item{% if has_sidebar %} large--four-fifths grid-border--left{% endif %}">

    {% comment %}
      Different markup if description is set
    {% endcomment %}
    {% if collection.description != blank %}
      <header class="section-header">
        <h1 class="section-header--title">{{ collection.title }}</h1>
        <div class="rte rte--header">
          {{ collection.description }}
        </div>
      </header>
      <hr class="hr--offset-left">
      <div class="section-header">
        <div class="section-header--right">
          {% include 'collection-sorting' %}
          {% include 'collection-views' %}
          {% include 'toggle-filters' %}
        </div>
      </div>
    {% else %}
    <header class="section-header">
      <h1 class="section-header--title section-header--left">{{ collection.title }}</h1>
      <div class="section-header--right">
        {% include 'collection-sorting' %}
        {% include 'collection-views' %}
        {% include 'toggle-filters' %}
      </div>
    </header>
    {% endif %}

    <div class="grid-uniform">

      {% for product in collection.products %}
        
        {% if has_sidebar %}
          {% assign grid_item_width = 'large--one-quarter medium--one-third small--one-half' %}
        {% else %}
          {% assign grid_item_width = 'large--one-fifth medium--one-third small--one-half' %}
        {% endif %}
        {% include 'product-grid-item' %}

      {% else %}

        <div class="grid-item">
          <p>{{ 'collections.general.no_matches' | t }}</p>
        </div>

      {% endfor %}

    </div>
    

  </div>

  {% if paginate.pages > 1 %}
  <div class="grid-item pagination-border-top">
    <div class="grid">
      <div class="grid-item{% if has_sidebar %} large--four-fifths push--large--one-fifth{% endif %}">
          <div class="text-center">
            {% include 'pagination-custom' %}
          </div>
      </div>
    </div>
  </div>
  {% endif %}
  
  {% endpaginate %}

</div>





<div class="form-horizontal">
  <label for="sortBy" class="small--hide">{{ 'collections.sorting.title' | t }}</label>
  <select name="sortBy" id="sortBy">
    <option value="manual">Featured</option>
    <option value="best-selling">Best Selling</option>
    <option value="title-ascending">Alphabetically, A-Z</option>
    <option value="title-descending">Alphabetically, Z-A</option>
    <option value="price-ascending">Price, low to high</option>
    <option value="price-descending">Price, high to low</option>
    <option value="created-descending">Date, new to old</option>
    <option value="created-ascending">Date, old to new</option>
    <option name="pnt3" value= 3 >Paginate3</option>
    <option name="pnt7" value= 8 >Paginate8</option>
    
    name="amount1"
  </select>
</div>

<script>
  Shopify.queryParams = {};
  if (location.search.length) {
    for (var aKeyValue, i = 0, aCouples = location.search.substr(1).split('&'); i < aCouples.length; i++) {
      aKeyValue = aCouples[i].split('=');
      if (aKeyValue.length > 1) {
        Shopify.queryParams[decodeURIComponent(aKeyValue[0])] = decodeURIComponent(aKeyValue[1]);
      }
    }
  }
  
  
 
  $(function() {
    $('#sortBy')
      // select the current sort order
      .val('{{ collection.sort_by | default: collection.default_sort_by | escape }}')
      .bind('change', function() {
        Shopify.queryParams.sort_by = jQuery(this).val();
        var sqp = Shopify.queryParams.sort_by
      //  alert(Shopify.queryParams.sort_by);
              var tt=jQuery.param(Shopify.queryParams).replace(/\+/g, '%20');
      var ss= jQuery.param(Shopify.queryParams).replace(/\+/g, '%20');
//       alert(ss);
      var split = ss.split('&');
      var aone = split[0];
      var atow = aone.split('=');
      var athree= atow[1];
    
      //alert(athree);
      //alert(sqp);
      //alert(ss);
      
         if (sqp=='manual' || sqp=='best-selling' || sqp=='title-ascending' || sqp=='title-descending' || sqp=='price-ascending' || sqp=='price-descending' || sqp=='created-descending' || sqp=='created-ascending')
         {
           location.search = jQuery.param(Shopify.queryParams).replace(/\+/g, '%20');
          
          }
         else{
       alert('PAGINATE');
           location.search = "view="+athree+"&sort_by="+sqp
          
        }
      }
    );
  });
</script>