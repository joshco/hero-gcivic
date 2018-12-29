# ENGINE ROUTES
Hero::Gcivic::Engine.routes.draw do

  match 'run' => 'tools#run', via: [:post,:get]
end