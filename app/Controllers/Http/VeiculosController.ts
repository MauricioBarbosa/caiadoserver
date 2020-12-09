import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import UsuarioCliente from 'App/Models/UsuarioCliente';
import Cliente from 'App/Models/Cliente';

export default class VeiculosController {
    
    public async obterVeiculos({response, auth}: HttpContextContract){
        try {
            await auth.use('api').authenticate(); 

            const user = auth.use('api').user; 

            if(user!=null){
                const cliente = await Cliente.findBy('id', user.clienteId); 
                if(cliente != null){
                   await cliente.preload('veiculos') 
                   for(var i=0; i < cliente.veiculos.length; i++){
                       await cliente.veiculos[i].preload('marca');
                   }
                response.status(200).json(cliente.veiculos);
                }
            }
        } catch (error) {
            console.log(error);
            if(error.code === 'E_INVALID_API_TOKEN')
                response.status(402).json({erro: 402 ,msg: 'Usuário não autenticado'});
            else 
                response.status(500).json({erro: 400, msg: 'Erro interno no servidor'});
        }
    }
}
