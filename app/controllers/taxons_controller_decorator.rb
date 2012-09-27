Spree::TaxonsController.class_eval do
  def show
    @taxon =  Spree::Taxon.find_by_permalink!(params[:id])
    return unless @taxon

    params[:user_id] = try_spree_current_user.id if try_spree_current_user
    @searcher = Spree::Config.searcher_class.new(params.merge(:taxon => @taxon.id))
    @products = @searcher.retrieve_products

    respond_with(@taxon)
  end
end