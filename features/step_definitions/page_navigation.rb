ParameterType(
  name:        'symbol',
  regexp:      /\w+/,
  type:        Symbol,
  transformer: ->(s) { s.to_sym }
)

Given("I am on the {symbol} page") do |page|
  pages = {
    front: '/'
  }
  visit 'http://localhost:3000' + pages.fetch( page, '/' )
end
