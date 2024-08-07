# config/initializers/enumerable_patch.rb
module Enumerable
  def filter_map
    return to_enum(:filter_map) unless block_given?
    each_with_object([]) do |element, result|
      value = yield(element)
      result << value if value
    end
  end
end