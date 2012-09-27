Spree::Admin::ProductsHelper.class_eval do
  def roles_for(product)
    options = @roles.map do |role|
      selected = product.roles.include?(role)
      content_tag(:option,
                  :value    => role.id,
                  :selected => ('selected' if selected)) do
        role.name
      end
    end.join("").html_safe
  end
end