/*
 * Facilitate adding new entries into our lists of relationships
 */
jQuery.fn.extendableList = function () {
  return this.change(function(elem) {
    var $select = $(elem.target);
    var $the_list = $select.parent().prev('ul');
    $the_list.children('.remove').remove();

    if ($the_list.length > 0) {
      ident = elem.target.id.replace('new_', '');
      var selected = elem.target.options[this.selectedIndex];
      var text = $(selected).text();
      var value = selected.value;
      var resource = $select.findResource();
      var list_id = $the_list[0].id;
      var counter = counters[list_id];
      counters[list_id]++;
      alert(list_id);
      $new_stuff = $('<li class="new"></li>');
      $new_stuff.append('<input type="hidden" name="' + resource + '[' + list_id + '_attributes][new_' + counter + '][' + ident + ']" value="' + value  + '" />');
      $new_stuff.append(text);
      $new_stuff.append($('<a href="#"> remove</a>').click(function() {
        $(this).parent().remove();
        return false;
      }));
      $the_list.append($new_stuff);
    }
  });
}

var HasMany = {
  wrangleAttributes: function(entity, index) {
    match_string = '';
    var matcher = new RegExp(match_string + "\\]\\[0\\]"); 

    $parts = $('input,select', entity);
    $parts.each(function () {
      $this = $(this);
      var new_name = $this.attr('name').replace(matcher, match_string + "][" + index + "]");        
      $this.attr('name', new_name);
    });
  
    
    return false;
  },
  
  clear: function(container) {
    container.find('input,textarea').attr('value', '');
  },
  
  removeNew: function() {
    if (this.parentNode.nodeName.toUpperCase() == 'LI') {
      $(this.parentNode).remove();
    } else {
      parent = $(this).parents('div:first,li:first');

      if (parent[0].nodeName.toUpperCase() == 'LI' || parent.siblings('div').length > 1) {
        parent.remove();
      } else {
        HasMany.clear(parent);
      }
      
    }
    
    return false;
  },
  
  removeExisting: function() {
    if (this.parentNode.nodeName.toUpperCase() == 'LI') {
      $div = $(this.parentNode);
    } else {
      $div = $(this).parents('div:first');
    }
    $div.find('.should-destroy')[0].value = 1;
    $div.hide();
    return false;
  },
  
  addNew: function() {
    $predecessors = $(this).parent().prev('ul').children('li');
    $initial = $(this).parent().prev('ul').children('li:first');
    $predecessor = $(this).parent().prev('ul').children('li:last');
    $partial = $initial.clone(true);    
    $partial.insertAfter($predecessor);
    HasMany.wrangleAttributes($partial, $predecessors.length);
    $partial.find('input,textarea').val('');
    return false;
  },
  
  attach: function(selector) {
    var $selector = $(selector);
    $('.new .remove-link', $selector).click(HasMany.removeNew);
    $('.old .remove-link', $selector).click(HasMany.removeExisting);
    $('a.add-link', $selector).click(HasMany.addNew);
  }
}
