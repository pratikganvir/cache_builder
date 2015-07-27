# CacheBuilder

Make dynamic pages look like it was always in cache. I was stuck in speeding
up my Rails website. It was very slow even when there are very few queries.
I found out that cache can save me. I started using the cache and wow my website
became 400% faster. The only slowness was in the dynamic pages because first time when user sees it it was not in cache. So I have started writing this library to build the cache for the dynamic pages. Now when user visits my website first time
it is way too fast.

Add this line to your application's Gemfile:

```ruby
gem 'cache_builder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cache_builder

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/cache_builder/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
