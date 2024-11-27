# class ProductsController < ApplicationController
#   def index
#     # if params[:search].present?
#       scope = Product
#         .search(params[:search])
#         .by_category(params[:category])
#         # .by_price(params[:price_range])
#       log_search_term(params[:search])
#     # end
#     @pagy, @products = pagy(scope, items: 10)
#   end
#   private

#   def log_search_term(term)
#     search_log = SearchLog.find_or_initialize_by(term: term.downcase)
#     search_log.increment(:count, 1)
#     search_log.save
#   end
# end

class ProductsController < ApplicationController
  def index
    @categories = Product.distinct.pluck(:category)
    # @price_ranges = [["Under $50", 0..50], ["$50-$100", 50..100], ["Over $100", 100..Float::INFINITY]]
    @products = Product.all

    if params[:category].present?
      @products = @products.where(category: params[:category])
    end

    if params[:search].present?
      log_search_term(params[:search]) # Log searches
      @products = @products.search_by_name(params[:search])
    end

    @pagy, @products = pagy(@products)
  end

  private

  def log_search_term(term)
    search_log = SearchLog.find_or_initialize_by(term: term.downcase)
    search_log.increment(:count, 1)
    search_log.save
  end
end
