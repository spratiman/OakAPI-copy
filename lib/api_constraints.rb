class ApiConstraints
  def initialize(options)
    @version = options[:version]
  end

  def matches?(req)
    req.headers['Accept'].include?("application/vnd.oak.v#{@version}")
  end
end