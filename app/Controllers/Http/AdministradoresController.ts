 //import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

import View from "@ioc:Adonis/Core/View";
import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Administrador from  "App/Models/Administrador";
import UsuarioAdministrador from "App/Models/UsuarioAdministrador";
import { Md5 } from "md5-typescript";

export default class AdministradoresController {
    //views
    public index({session, auth} : HttpContextContract){
        if(auth.use('web').user != null && auth.use('web').user != undefined){
            const usr = auth.use('web').user; 
            if(usr!=null&&usr.nivel < 2){
                return View.render('_usuarioAdministrador/index', {
                    user: session.get('user'),
                    admin: session.get('admin')
                });
            }
        }
    }

    public indexCadastrar({session, auth}: HttpContextContract){
        if(auth.use('web').user != null && auth.use('web').user != undefined){
            const usr = auth.use('web').user;
            if(usr!= null&&usr.nivel == 1){
                return View.render('_usuarioAdministrador/usuario', {
                    user: session.get('user'),
                    admin: session.get('admin')
                })
            }else{
                return View.render('errors/not-permitted');
            }
        }
    }

    public indexAlterar({session, auth}: HttpContextContract){
        if(auth.use('web').user != null && auth.use('web').user != undefined){
            const usr = auth.use('web').user;
            if(usr!=null&&usr.nivel == 1){
                return View.render('_usuarioAdministrador/alterar', {
                    user: session.get('user'),
                    admin: session.get('admin')
                })
            }else{
                return View.render('errors/not-permitted');
            }
        }
    }

    public async cadastrar({request, response} :  HttpContextContract){

        var dados = request.all();

        const usuario_administrador = new UsuarioAdministrador(); 
        const administrador = new Administrador();

        administrador.$attributes = dados.administrador; 
        usuario_administrador.$attributes = dados.usuario;

        console.log(administrador); 
        console.log(usuario_administrador);

        usuario_administrador.senha = Md5.init(dados.usuario.senha);

        try{
            await usuario_administrador.related('administrador').associate(administrador);
            response.status(200).json({code: 2000,inserido: true, msg: 'usuario cadastrado'})
        }catch(error){
            console.log(error);
            if(error.errno == 1062){
                response.status(502).json({code: 1062,inserido: false, msg: 'Já existe um usuário com este username!'})
            }else{
                response.status(502).json({code: 1000 ,inserido: false, msg: 'Não foi possível inserir'})
            }
        }
    }

    public async getAll({response, auth}: HttpContextContract){
        if(auth.use('web').user != null && auth.use('web').user != undefined){
            const user = auth.use('web').user; 
            if(user!=null&&user.nivel == 1){
            const usuarios = await UsuarioAdministrador
            .query()
            .preload('administrador');

            console.log(usuarios);
            response.status(200).json(usuarios);
            }else{
                return View.render('errors/not-permitted');
            }
        }
    }
}
