import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Marca from 'App/Models/Marca';

export default class MarcasController {

    public async obterMarcas({response, auth}: HttpContextContract){
        try{
            await auth.use('api').authenticate();
            const marcas = await Marca.all();
            console.log(marcas);
            response.status(200).json(marcas);
        }catch(error){
            if(error.code === 'E_INVALID_API_TOKEN')
            response.status(402).json({erro: 402 ,msg: 'Usuário não autenticado'});
            else 
            response.status(500).json({erro: 400, msg: 'Erro interno no servidor'});
        }
    }
}
