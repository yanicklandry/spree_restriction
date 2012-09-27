Spree::ProductsController.class_eval do
  def index
    params[:user_id] = try_spree_current_user.id if try_spree_current_user
    @searcher =  Spree::Config.searcher_class.new(params)
    @products = @searcher.retrieve_products
    respond_with(@products)
  end
end