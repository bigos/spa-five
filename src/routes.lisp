(in-package :spa-five)

;;; list of functions for adding to the dispatch-table
(server:add-routes
 (list
  ;; static assets
  (hunchentoot:create-prefix-dispatcher "/javascripts/"  'handlers::assets)
  (hunchentoot:create-prefix-dispatcher "/stylesheets/"  'handlers::assets)
  (hunchentoot:create-prefix-dispatcher "/img/"          'handlers::assets)
  (hunchentoot:create-prefix-dispatcher "/spa"           'handlers::spa)
  ;; routes where we might need arguments passed by script-name
  (server:create-custom-dispatcher :get "/parenscripts/:file"  'handlers::parenscripts)
  (server:create-custom-dispatcher :all "/foo"                 'handlers::foo1)
  (server:create-custom-dispatcher :get "/contact/:action/:id" 'handlers::baz)
  (server:create-custom-dispatcher :get "/baz/:subj/has/:obj"  'handlers::baz)
  (server:create-custom-dispatcher :get "/bar"                 'handlers::bar)
  ;; regex routes
  (hunchentoot:create-regex-dispatcher "\\A/about\\z" 'handlers::about)
  ;; finally route to home page making sure the regex is terminated with \z
  (hunchentoot:create-regex-dispatcher "\\A/\\z" 'handlers::home)))

;;; Start VHOST
(server:restart-acceptor)
