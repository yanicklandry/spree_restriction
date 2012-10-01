SpreeRestriction
================

Spree extension for adding visibility restriction by roles to products.

Installation
------------

Add the following line to your Gemfile :

    gem 'spree_restriction'
    
And then execute the following commands at the root of your application :

    bundle # to update the installed gems
    rails g spree_restriction:install # to install the extension's migrations and other files into your application

Usage
=====

In the admin mode, go to a product and select a role in the Restriction field (at the very bottom of the page). Click update and then logout. Notice that the product is not visible anymore when the required role is not logged in.

Testing
-------

I did not implemented any rspec testing yet.

Copyright (c) 2012 [name of extension creator], released under the New BSD License
