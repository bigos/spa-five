(in-package :spa-five)

;;; list of functions for adding to the dispatch-table
(server:add-routes
 (reverse ; need to reverse to have the top routes dispatched first
  (list
   ;; static assets
   (hunchentoot:create-prefix-dispatcher "/javascripts/"  'handlers::assets)
   (hunchentoot:create-prefix-dispatcher "/stylesheets/"  'handlers::assets)
   (hunchentoot:create-prefix-dispatcher "/img/"          'handlers::assets)
   ;; routes where we might need arguments passed by script-name
   (server:create-custom-dispatcher :get "/parenscripts/:file"  'handlers::parenscripts)
   (server:create-custom-dispatcher :all "/foo"                 'handlers::foo1)
   (server:create-custom-dispatcher :get "/contact/:action/:id" 'handlers::baz)
   (server:create-custom-dispatcher :get "/baz/:subj/has/:obj"  'handlers::baz)
   (server:create-custom-dispatcher :get "/bar"                 'handlers::bar)
   ;; finally route to home page
   (hunchentoot:create-regex-dispatcher "\\/\\z" 'handlers::home))))

;;; Start VHOST
(server:restart-acceptor)
