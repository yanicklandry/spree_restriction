Deface::Override.new(:virtual_path => "spree/admin/products/_form",
                     :name => "admin_product_restriction",
                     :insert_top => "[data-hook='admin_product_form_additional_fields']",
                     :locals => {:stars => 3, :edit_enabled => true},
                     :text => '<h2><%= t(:restriction_label) %></h2>
                     <div data-hook="admin_product_restrictions">
                                 <%= f.field_container :restrictions do %>
    <%= f.label :role_ids, t(:restriction_description) %><br />
      <%= f.select :role_ids, roles_for(@product), {}, :class => "select2", :multiple => true %>
    <% end %>
  </div>',
                     :disabled => false)
