Spree::Role.class_eval do
  has_and_belongs_to_many :products, :join_table => 'spree_restrictions'
end