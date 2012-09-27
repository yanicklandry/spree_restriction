Spree::Admin::ProductsController.class_eval do
  def load_data
    @taxons = Spree::Taxon.order(:name)
    @option_types =  Spree::OptionType.order(:name)
    @tax_categories =  Spree::TaxCategory.order(:name)
    @shipping_categories =  Spree::ShippingCategory.order(:name)
    @roles =  Spree::Role.order(:name)
  end
end
