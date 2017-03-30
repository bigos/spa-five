(in-package :spa-five)

;;; list of functions for adding to the dispatch-table
(server:add-routes
 (list
  ;(hunchentoot:create-prefix-dispatcher "/javascripts/"  'handlers::assets)
  (hunchentoot:create-prefix-dispatcher "/stylesheets/"  'handlers::assets)

  (server:create-custom-dispatcher :get "/parenscripts/:file" 'handlers::parenscripts)
  (server:create-custom-dispatcher :all "/foo" 'handlers::foo1)
  (server:create-custom-dispatcher :get "/contact/:action/:id" 'handlers::baz)
  (server:create-custom-dispatcher :get "/baz/:subj/has/:obj"  'handlers::baz)
  (server:create-custom-dispatcher :get "/bar" 'handlers::bar)
  (server:create-custom-dispatcher :get "/home" 'handlers::home)))

;;; Start VHOST
(server:restart-acceptor)
