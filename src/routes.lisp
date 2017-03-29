(in-package :spa-five)

;;; list of functions for adding to the dispatch-table
(server:add-routes
 (list (server:create-custom-dispatcher :all "/foo" 'handlers::foo1)
       (server:create-custom-dispatcher :get "/contact/:action/:id" 'handlers::baz)
       (server:create-custom-dispatcher :get "/baz/:subj/has/:obj"  'handlers::baz)
       (server:create-custom-dispatcher :get "/bar" 'handlers::bar)))

;;; Start VHOST
(server:restart-acceptor)
