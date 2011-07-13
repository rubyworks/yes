module YES

  class And < Array
    def intialize(data)
      concat(data)
    end
  end

  YAML.add_domain_type('http://rubyworks.github.com/yes', 'and') do |data|
    And.new(data)
  end

end
