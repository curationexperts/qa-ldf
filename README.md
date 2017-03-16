QuestioningAuthority::LDF
=========================
[![Apache 2.0 License](http://img.shields.io/badge/APACHE2-license-blue.svg)](./LICENSE)

This sofware providies bindings from [Questioning Authority](https://github.com/projecthydra-labs/questioning_authority) to the [linked data caching fragment server](https://github.com/ActiveTriples/linked-data-fragments) for fast query of RDF-based authorities.

What Does This Do?
------------------

This gem offers a caching version of the [Questioning Authority](https://github.com/projecthydra-labs/questioning_authority) interface relying on the ActiveTriples LDF caching service. A set of linked data "authorities" are exposed through the Questioning Authority API, and cached for fast recall using the Linked Data Fragments Caching Server. Models on the Hydra/Rails side are provided to handle caching and easy presentation of labels.

Both the QA and LDF APIs are available in mountable forms, so they can run directly in your Hydra application---see below for details.

### Why use this?

The main reason you may be interested in this software is to handle local caching of linked data references in your metadata.

### Upcoming features include:

  - Support for `Qa::Authority::Base#all` for all LDF authorities through [Hydra Core Partial Collection View](http://www.hydra-cg.com/spec/latest/core/#hydra:PartialCollectionView) style paging.
  - A default search, accessing only cached items.

How Does it Work?
-----------------

### [TK] Architecture Overview.
### Mounting and configuring the LDF caching server

The LDF caching server can run as a mounted application within Rails. To use the caching server, add the following to your `Gemfile`:

```ruby
gem 'qa-ldf', '~>0.2.0'

# for now use the active branch of the linked data caching fragment server
gem 'ld_cache_fragment', github: 'ActiveTriples/linked-data-fragments', branch: 'feature/multi-dataset'
```

Then you need to mount the application to an unused route:

```ruby
# config/routes.rb

Rails.application.routes.draw do
  # ...
  mount LinkedDataFragments::CacheServer::APPLICATION => '/ldcache'
  # ...
end
```

### LDF caching as an external service.

The LDF caching server can run independently from your Hydra application as a lightweight, generic [Rack](http://www.rubydoc.info/github/rack/rack/file/SPEC) application, or as a standalone Rails app. You may want to deploy the server in this way so it can run on separate hardware, or to segregate Linked Data "follow your nose" network traffic.

The simplest way to get a working application that will run on any Rack-compatible server is to create a `./config.ru` containing:

```ruby
# ./config.ru
require 'ld_cache_fragment/cache_server'

run LinkedDataFragments::CacheServer::APPLICATION
```

With this in your working directory, you can run `$ rackup` to launch a basic server. More robust deployments are possible using servers like [Puma](https://github.com/puma/puma#rackup).

#### [TK] LDF caching as a Rails app

### Configuring authorities.
#### [TK] Models.
#### [TK] Forms.

Authority Sources
----------------------

### LCNAF

The Library of Congress Name Authority File

### FAST

Faceted Application of Subject Terminology

[TK] Implementing Custom Authorities
------------------------------------

License
-------

This software is available under {file:LICENSE the Apache 2.0 license}.
