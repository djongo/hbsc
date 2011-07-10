function add_child(element, child_name, new_child) {
  $(child_name + '_children').insert({
    bottom: new_child.replace(/NEW_RECORD/g, new Date().getTime())
  });
  // The following code adds information to the publication string to 
  // force a new version
  var change_string = Form.Element.getValue("publication_change") + " +" + child_name;  
  Form.Element.setValue("publication_change",change_string)
}

//function add_child_change_previous(element, child_name, new_child) {
//  $(child_name + '_children').insert({
//    bottom: new_child.replace(/NEW_RECORD/g, new Date().getTime())
//  });
//	$(element).insert({bottom: "<br /> @authorships.user_name "});
//}


function remove_child(element) {
  var hidden_field = $(element).previous("input[type=hidden]");
  if (hidden_field) {
    hidden_field.value = '1';
  }
  $(element).up(".child").hide();
  // The following code adds information to the publication string to 
  // force a new version  
  var change_string = Form.Element.getValue("publication_change") + " -" + $(element).up(".child").readAttribute("id");
  Form.Element.setValue("publication_change",change_string)
}
