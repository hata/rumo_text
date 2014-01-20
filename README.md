# rumo_text

This library is wrapper classes to use Core Text in RubyMotion. It can help
to use attributes to draw text.

## Installation

Add this line to your application's Gemfile:

    gem 'rumo_text'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rumo_text

## Usage

iOS document says that some text related APIs will be deprecated.
For example, CGContextSelectFont and CGContextShowText are
deprecated. It says that we should use Core Text instead.
From this, the purpose of this library is to draw a text easily
without using the [Deplicated APIs](https://developer.apple.com/library/ios/documentation/graphicsimaging/Reference/CGContext/DeprecationAppendix/AppendixADeprecatedAPI.html).

Add the following like to Rakefile in RubyMotion project:

```
require 'rumo_text'
```

In RubyMotion code, add include like this:

```
include RumoText
```

and then use like this(or just use RumoText::AttrText):

```
attr_text = AttrText.new
attr_text.draw(context, CGRectMake(10, 10, 300, 100), 'Hello World')
```

Attributes can set like the following ways and then draw it.

```
attr_text = AttrText.new
attr_text.kern = 1
attr_text.foreground_color = UIColor.yellowColor
attr_text.stroke_color = UIColor.redColor
attr_text.underline_style.style_single = true
attr_text.underline_style.pattern_dash = true
attr_text.paragraph_style.head_indent = 10
attr_text.paragraph_style.alignment = CTTextAlignment.center
# ...
attr_text.draw(context, CGRectMake(10, 10, 300, 100), 'foo bar')
```

Attributes comes from [Core Text String Attributes Reference](https://developer.apple.com/library/mac/documentation/Carbon/reference/CoreText_StringAttributes_Ref/Reference/reference.html)
paragraph_style attributes comes from [CTParagraphStyleSpecifier](https://developer.apple.com/library/mac/documentation/Carbon/reference/CTParagraphStyleRef/Reference/reference.html) .


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## TODO
This doesn't handle detals of other classes. Right now, I just focus on to set attribute easier than using NSAttributeString.
