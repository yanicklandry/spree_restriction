Spree::Core::Search::Base.class_eval do
  def get_base_scope
    roles = @properties[:user_id] ? Spree::User.find(@properties[:user_id]).spree_roles.dup : []
    base_scope = Spree::Product.active
    base_scope = base_scope.by_roles(roles)
    base_scope = base_scope.in_taxon(taxon) unless taxon.blank?
    base_scope = get_products_conditions_for(base_scope, keywords)
    base_scope = base_scope.on_hand unless Spree::Config[:show_zero_stock_products]
    base_scope = add_search_scopes(base_scope)
    base_scope
  end

  def prepare(params)
    @properties[:taxon] = params[:taxon].blank? ? nil : Spree::Taxon.find(params[:taxon])
    @properties[:keywords] = params[:keywords]
    @properties[:search] = params[:search]

    per_page = params[:per_page].to_i
    @properties[:per_page] = per_page > 0 ? per_page : Spree::Config[:products_per_page]
    @properties[:page] = (params[:page].to_i <= 0) ? 1 : params[:page].to_i
    @properties[:user_id] = params[:user_id]
  end
end
