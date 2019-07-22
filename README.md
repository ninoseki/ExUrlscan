# ExUrlscan

![Hex.pm](https://img.shields.io/hexpm/v/ex_urlscan.svg)
[![Build Status](https://travis-ci.org/ninoseki/ExUrlscan.svg?branch=master)](https://travis-ci.org/ninoseki/ExUrlscan)
[![Coverage Status](https://coveralls.io/repos/github/ninoseki/ExUrlscan/badge.svg?branch=master)](https://coveralls.io/github/ninoseki/ExUrlscan?branch=master)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/fc6da78722d54e9796e8463909ed8690)](https://www.codacy.com/app/ninoseki/ExUrlscan)

## Description

Elixir API client for [urlscan.io](https://urlscan.io/).

## Installation

Add ExUrlscan to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ex_urlscan, "~> 0.1"}]
end
```

Pass your API key via the mix configuration:

```elixir
config :ex_urlscan,
  api_key: "YOUR_API_KEY"
```

Or, pass the API key via `URLSCAN_API_KEY` environment variable.

```bash
export URLSCAN_API_KEY="YOUR_API_KEY"
```

## Usage

```elixir
uuid = "xxx"

# result
ExUrlscan.V1.Client.result(uuid)

# dom
ExUrlscan.V1.Client.dom(uuid)

# search
ExUrlscan.V1.Client.search(q: "domain:urlscan.io")

# scan
ExUrlscan.V1.Client.scan("http://github.com")
ExUrlscan.V1.Client.scan("http://github.com", public: "off")
```

## TODO

- Structuring responses
- More solid input validations
