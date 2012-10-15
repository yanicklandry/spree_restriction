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

if (defined? Spree::Core::Search::ProductGroupBase)
  Spree::Core::Search::ProductGroupBase.class_eval do
    def get_base_scope
      roles = @properties[:user_id] ? Spree::User.find(@properties[:user_id]).spree_roles.dup : []
      base_scope = @cached_product_group ? @cached_product_group.products.active : Spree::Product.active
      base_scope = base_scope.by_roles(roles)
      base_scope = base_scope.in_taxon(taxon) unless taxon.blank?
      base_scope = get_products_conditions_for(base_scope, keywords) unless keywords.blank?

      base_scope = base_scope.on_hand unless Spree::Config[:show_zero_stock_products]
      base_scope = base_scope.group_by_products_id if @product_group.product_scopes.size > 1
      base_scope
    end

    def prepare(params)
      @properties[:taxon] = params[:taxon].blank? ? nil : Spree::Taxon.find(params[:taxon])
      @properties[:keywords] = params[:keywords]

      per_page = params[:per_page].to_i
      @properties[:per_page] = per_page > 0 ? per_page : Spree::Config[:products_per_page]
      @properties[:page] = (params[:page].to_i <= 0) ? 1 : params[:page].to_i

      if !params[:order_by_price].blank?
        @product_group = Spree::ProductGroup.new.from_route([params[:order_by_price] + '_by_master_price'])
      elsif params[:product_group_name]
        @cached_product_group = Spree::ProductGroup.find_by_permalink(params[:product_group_name])
        @product_group = Spree::ProductGroup.new
      elsif params[:product_group_query]
        @product_group = Spree::ProductGroup.new.from_route(params[:product_group_query].split('/'))
      else
        @product_group = Spree::ProductGroup.new
      end
      @product_group = @product_group.from_search(params[:search]) if params[:search]
      @properties[:user_id] = params[:user_id]
    end
  end
end