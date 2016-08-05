# MobileExport

[![Gem Version](https://badge.fury.io/rb/mobile_export.svg)](https://badge.fury.io/rb/mobile_export)
[![Build Status](https://travis-ci.org/JuanitoFatas/mobile_export.svg?branch=master)](https://travis-ci.org/JuanitoFatas/mobile_export)

Organize your images for Android.

Given:

```
folder/
├── base_h.png
├── base_hhh.png
├── base_m.png
├── base_xh.png
└── base_xxh.png
```

After `mobile_export`:

```
folder/
├── drawable-hdpi
│   └── base.png
├── drawable-hhhdpi
│   └── base.png
├── drawable-mdpi
│   └── base.png
├── drawable-xhdpi
│   └── base.png
└── drawable-xxhdpi
    └── base.png
```

## Installation

    $ gem install mobile_export

## Usage

    $ mobile_export

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JuanitoFatas/mobile_export.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
