module PublicationsHelper

  def remove_child_link(name, form_builder)
    form_builder.hidden_field(:_destroy) + link_to_function(name, "remove_child(this)")
  end

  def add_child_link(name, child, form_builder)
    fields = escape_javascript(new_child_fields(child, form_builder))
    link_to_function(name, h("add_child(this, \"#{child}\", \"#{fields}\")"))
  end

  def add_child_change_link(name, child, form_builder)
    fields = escape_javascript(new_child_fields(child, form_builder))
    link_to_function(name, h("add_child_change_previous(this, \"#{child}\", \"#{fields}\")"))
  end

  def new_child_fields(child, form_builder)
    form_builder.fields_for(child.pluralize.to_sym, child.camelize.constantize.new, :child_index => 'NEW_RECORD') do |f|
      render(:partial => child.underscore, :locals => { :f => f })
    end
  end

# in the form
#         <%= add_child_link "Add a keyword", 'keyword', f  %> 
# in the partial
#   <%= remove_child_link 'remove', f %>

#  def workflow_links(state)
#    case state
#    when "preplanned"
#      link_to_function()
#      
#      link_to "Submit", submit_planned_publication_path(@publication), :method => :put if permitted_to? :submit, :publications
#    when "preplanned_submitted"
#  <%= link_to "Accept as planned", preplanned_accept_publication_path(@publication), :method => :put if permitted_to? :progress, :publications %> | 
#  <%= link_to "Reject as planned", preplanned_reject_publication_path(@publication), :method => :put if permitted_to? :progress, :publications %>      
#    end
#  end

#case test
#when "cat"
#  "meow"
#when "dog"
#  "woof"
#when /^cow/
#  "moo!"
#end

#  
  
end
