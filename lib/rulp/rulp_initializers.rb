module Rulp
  module Initializers
    def initialize(name, args)
      @name = name
      @args = args
      @value = nil
      @identifier = "#{self.name}#{self.args.join("_")}"
    end

    def to_s
      @identifier
    end
  end
end

