# ENGINE ROUTES
Hero::Gcivic::Engine.routes.draw do

  match 'run' => 'hero/gcivic/tools#run', via: [:post,:get]
end