import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

import View from "@ioc:Adonis/Core/View";
import { Md5 } from 'md5-typescript';
import UsuarioAdministrador from 'App/Models/UsuarioAdministrador';
import Administrador from 'App/Models/Administrador';

export default class AuthAdministradoresController {

    async index(){
        return View.render('Login/login');
    }

    public async login({auth, request, response, session, view}: HttpContextContract){

        const username = request.input('username'); 
        const password = Md5.init(request.input('senha'));

        try{

            const user = await UsuarioAdministrador.
            findBy('usuario_administrador_usuario', username)

            console.log(user);

            if(user!= null && user.senha == password && user.ativo){
                const admin = await Administrador.find(user.administradorId);
                auth.login(user); 
                session.put('user', user);
                if(admin != null){
                    session.put('admin', admin);
                }
                response.redirect('/')
            }else{
                if(user != null){
                    if(!user.ativo){
                        session.flash({
                            error : 'Usuário Invativo'
                        });
                    }
                    else if(user.senha != password){
                        session.flash({
                            error : 'Senha Inválida'
                        });
                    }
                }else{
                    session.flash({
                        error: 'Usuário inexistente'
                    });
                }
                response.redirect().back();
            }
        }catch(error){
            console.log(error);
        }
    }

    async logout({auth, response}: HttpContextContract){
        await auth.logout();
        response.redirect('/login');
    }
}
