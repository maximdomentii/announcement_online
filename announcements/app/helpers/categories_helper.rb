module CategoriesHelper
  def get_all_categories
    @categories = Category.all
  end
end
