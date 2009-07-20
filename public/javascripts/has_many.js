jQuery.fn.clearForm = function() {
  return this.each(function() {
    var type = this.type, tag = this.tagName.toLowerCase();
    
    if (type == 'text' || type == 'password' || tag == 'textarea') {
      this.value = '';
    } else if (type == 'checkbox' || type == 'radio') {
      this.checked = false;
    } else if (tag == 'select') {
      this.selectedIndex = -1;
    } else {
      return $(':input', this).clearForm();
    }
  });
};

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
  wrangleAttributes: function(entity, index, offset) {
    if (! offset) {
      offset = 0;
    }
    match_string = '';
    var matcher = new RegExp(match_string + "\\]\\[" + offset + "\\]"); 

    $parts = $('input,select', entity);
    $parts.each(function () {
      $this = $(this);
      var new_name = $this.attr('name').replace(matcher, match_string + "][" + index + "]");        
      $this.attr('name', new_name);
    });
  
    
    return false;
  },
  
  /*
   * TODO: remove dependency on being in a ul list
   */
  removeNew: function() {
    if (this.parentNode.nodeName.toUpperCase() == 'LI') {
      $(this.parentNode).remove();
    } else {
      parent = $(this).parents('div:first,li:first');

      if (parent[0].nodeName.toUpperCase() == 'LI' || parent.siblings('div').length > 1) {
        parent.remove();
      } else {
        $(parent).clearForm();
      }
      
    }
    
    return false;
  },
  
  /*
   * TODO: remove dependency on being in a ul list
   */
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
    $ul = $(this).parent().prev('ul');

    if ($ul.length == 0) {
      // it looks like we're in a table, not a ul
      $table = $(this).closest('table');
      $predecessors = $('tr.appearances', $table).not('.append');
    } else {
      $predecessors = $('li', $ul);
    }
    
    $initial = $predecessors.filter('.new:first');
    $predecessor = $predecessors.filter(':last');
    
    var offset = jQuery.inArray($initial[0], jQuery.makeArray($predecessors));
    $partial = $initial.clone(true);    
    $partial.insertAfter($predecessor);
    HasMany.wrangleAttributes($partial, $predecessors.length, offset);
    $partial.clearForm();
    return false;
  },
  
  attach: function(selector) {
    var $selector = $(selector);
    $('.new .remove-link', $selector).click(HasMany.removeNew);
    $('.old .remove-link', $selector).click(HasMany.removeExisting);
    $('a.add-link', $selector).click(HasMany.addNew);
  }
}
