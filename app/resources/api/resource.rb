class Api::Resource
  def include?(relation, options = {})
    return false if options[:include].nil?
    options[:include].split(',').include?(relation.to_s)
  end
end