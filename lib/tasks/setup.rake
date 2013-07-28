task :setup => [ 'db:create', 'db:migrate', 'db:seed' ]
