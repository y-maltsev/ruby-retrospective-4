module UI
  module TextScreen
    def self.draw(style: nil, border: "", &block)
      proxy = Proxy.new(style: style)
      proxy.instance_eval(&block)
      result = border + proxy.result + border
    end
  end

  class Proxy
    attr_accessor :result

    def initialize (style:)
      @result = ""
      @style = style
    end

    def horizontal(style: nil, border: "", &block)
      style = @style if style == nil
      helper = Horizontal.new(style: style)
      helper.instance_eval(&block)
      @result = @result + border + helper.result + border
    end

    def vertical(style: nil, border: "", &block)
      style = @style if style == nil
      helper = Vertical.new(style: style, border: border)
      helper.instance_eval(&block)
      @result = @result +  helper.concatenate
    end

    def label(text: "", style: nil, border: "")
      style = @style if style == nil
      text = text.downcase if style == :downcase
      text = text.upcase if style == :upcase
      @result = @result + border + text + border
    end
  end

  class Horizontal < Proxy

  end

  class Vertical  < Proxy
    attr_accessor :parts

    def initialize (style:, border:)
      super(style: style)
      @parts = []
      @border = border
    end

    def horizontal(style: nil, border: "", &block)
      @result = ""
      @parts <<  super(style: style, border: border, &block)
    end

    def vertical(style: nil, border: "", &block)
      @result = ""
      @parts << super(style: style, border: border, &block)
    end

    def label(text: "", style: nil, border: "")
      @result = ""
      @parts << super(text: text, style: style, border: border)
    end

    def concatenate
      maximum = @parts.collect { |x| x = x.length }.max
      result = @parts.collect{ |x|
                                x = @border + x.ljust(maximum) + @border + "\n"
                             }.join
    end
  end
end