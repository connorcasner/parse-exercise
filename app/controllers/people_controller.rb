class PeopleController
  def initialize(params)
    @params = params
  end

  def normalize
    people = PercentParser.new(params[:percent_format]).people
    people += DollarParser.new(params[:dollar_format]).people
    people += PipeParser.new(params[:pipe_format]).people

    people.sort_by! { _1.public_send(params[:order]) }

    result = []
    people.each do |person|
      result << person.to_s
    end

    result
  end
  
  private
  
  attr_reader :params
end
