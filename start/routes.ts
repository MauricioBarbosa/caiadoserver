/*
|--------------------------------------------------------------------------
| Routes
|--------------------------------------------------------------------------
|
| This file is dedicated for defining HTTP routes. A single file is enough
| for majority of projects, however you can define routes in different
| files and just make sure to import them inside this file. For example
|
| Define routes in following two files
| ├── start/routes/cart.ts
| ├── start/routes/customer.ts
|
| and then import them inside `start/routes/index.ts` as follows
|
| import './cart'
| import './customer'
|
*/

import Route from '@ioc:Adonis/Core/Route';

//rotas do administrador
Route.post('login', 'AuthAdministradoresController.login');
Route.on('login').render('Login/login')
Route.get('/','IndicesController.index').middleware('auth:web');
Route.get('/administradores','AdministradoresController.index').middleware('auth:web');
Route.get('/cadastraradministradores','AdministradoresController.indexCadastrar').middleware('auth:web');
Route.post('/cadastraradministradores/cadastrar','AdministradoresController.cadastrar').middleware('auth:web');
Route.get('/cadastraradministradores/usuarios','AdministradoresController.getAll').middleware('auth:web');
Route.get('/cadastraradministradores/usuarios/alterar','AdministradoresController.indexAlterar').middleware('auth:web');
Route.get('/logout', 'AuthAdministradoresController.logout');


//Rotas do cliente

// não autenticadas
Route.post('/logincliente','ClientesController.login');
Route.post('/registrarcliente','ClientesController.registrar_cliente');

//autenticadas
Route.get('/obternome', 'ClientesController.obter_nome');
Route.get('/logoutcliente', 'ClientesController.logout');
Route.get('/carregarcliente', 'ClientesController.carregar_cliente');
Route.post('/alterarcliente', 'ClientesController.alterar_cliente');
Route.get('/check', 'ClientesController.check');

//autenticadas //Veiculo
Route.get('/obtermarcas', 'MarcasController.obterMarcas');
Route.get('/obterveiculos', 'VeiculosController.obterVeiculos');