import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import UsuarioCliente from 'App/Models/UsuarioCliente';

export default class AuthClientesController {

    public async login({response,request, auth}: HttpContextContract){
        const dados = request.all();
        console.log(dados.email);
        
         const cliente = await UsuarioCliente
         .findBy('usuario_cliente_email', dados.email);

         if(cliente!=null){
            console.log(cliente);

            const token = await auth.use('api').login(cliente, {
                expiresIn: '30 days'
            })
            response.status(200).json(token);
         }
    }
}
