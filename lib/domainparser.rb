class DomainParser
 attr_accessor :domains

  def initialize(file)
    @file = file
    @domains = parse_domains
  end

  private
  def parse_domains
    data =  File.read(@file)
    csv = CSV.parse(data)
    csv.each_with_object({}) do |domains, memo|
    memo[domains[0]] = domains[1..-1]
    end
  end
end
