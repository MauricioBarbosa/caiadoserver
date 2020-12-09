import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Cliente from 'App/Models/Cliente';
import { schema, rules } from '@ioc:Adonis/Core/Validator'; 
import Endereco from 'App/Models/Endereco';
import Usuario from 'App/Models/UsuarioCliente';
import UsuarioCliente from 'App/Models/UsuarioCliente';
import { Md5 } from 'md5-typescript';

export default class ClientesController {

    public async login({response, request, auth}: HttpContextContract){
        var dados = request.all(); 

        const usuarioCliente = await UsuarioCliente
         .findBy('usuario_cliente_email', dados.email);

        try{
            if(usuarioCliente != null){
                if(usuarioCliente.senha = Md5.init(dados.senha)){
                    const token = await auth.use('api').login(usuarioCliente, {
                        expiresIn: '30 days'
                    });
                    const cliente = await Cliente.findBy('id', usuarioCliente.clienteId);
                    console.log(token);
                    cliente != null ? response.status(200).json({token: token.token, nome: cliente.nome, email: usuarioCliente.email})
                    : response.status(500).json({code: 500, erro: 'E_SERVER_ERROR', msg: 'Erro Interno no Servidor'})
                }
                else{
                    response.status(500).json({code: 500,erro: 'E_INVALID_PASSWORD', msg: 'Senha inválida'});
                }
            }else{
                response.status(500).json({code: 500,erro: 'E_NOT_FOUND_USER', msg: 'Usuário Inexistente'});
            }
        }catch(erro){
            console.log('erro');
        }
    }

    public async registrar_cliente({response, request, auth}: HttpContextContract){
        var dados = request.all(); 

        const usuarioCliente = new UsuarioCliente();
        const cliente = new Cliente(); 

        cliente.nome = dados.cliente.nome; 
        cliente.cpf = dados.cliente.cpf;
        cliente.datanascimento = dados.cliente.datanascimento;
        cliente.sexo = dados.cliente.sexo;
        cliente.telefone = dados.cliente.telefone; 
        cliente.celular = dados.cliente.celular; 

        usuarioCliente.email = dados.usuario.email;
        usuarioCliente.senha = Md5.init(dados.usuario.senha);

        /*usuarioCliente.$attributes = dados.usuario; 
        cliente.$attributes = dados.cliente;  */
        console.log(usuarioCliente);
        console.log(cliente);

        try {
            await usuarioCliente.related('cliente').associate(cliente);
            const user = await UsuarioCliente
            .findBy('usuario_cliente_email', usuarioCliente.email); 
            if(user != null){
                const token = await auth.use('api').login(user, {
                    expiresIn: '30 days'
                });
                console.log(token);
                response.status(200).json({token: token.token, nome: cliente.nome, email: usuarioCliente.email});
            }else{
                throw new Error('Erro ao Cadastrar');
                response.status(500).json({erro: "E_CAD_ENTRY", msg: "Erro ao cadastrar"}); 
            }
        }catch (error) {
            console.log(error);
            if(error.errno == 1062){
                response.status(500).json({erro: "E_DUP_ENTRY", msg: "Já existe um usuário com esse e-mail"}); 
            }else{
                response.status(500).json({erro: "E_INT_ERROR", msg: "Erro ao inserir o usuário"}); 
            }
        }
    }

    public async alterar_cliente({request, response, auth}: HttpContextContract){
        try{
            await auth.use('api').authenticate(); 

            var dados = request.all();

            console.log(request);
            const user = auth.use('api').user; 
            if(user != null){
                const cliente = await Cliente.findBy('id',user.clienteId);
                if(cliente!=null){
                    cliente.nome = dados.cliente.nome; 
                    cliente.cpf = dados.cliente.cpf; 
                    cliente.datanascimento = dados.cliente.datanascimento; 
                    cliente.sexo = dados.cliente.sexo;
                    cliente.telefone = dados.cliente.telefone; 
                    cliente.celular = dados.cliente.celular;

                    await cliente.save(); 
                    response.status(200);
                }
            }
        }catch(erro){
            response.status(500);
        }
    }

    public async carregar_cliente({response, auth} : HttpContextContract){
        try{
            await auth.use('api').authenticate(); 
            const user = auth.use('api').user; 
            if(user!=null){
                const cliente = await Cliente.findBy('id', user.clienteId); 
            if(cliente != null)
                response.status(200).json({cliente}); 
            else
                response.status(500).json({erro: 400, msg: 'Erro interno no servidor'});
            }
        }catch(error){
            if(error.code === 'E_INVALID_API_TOKEN')
                response.status(402).json({erro: 402 ,msg: 'Usuário não autenticado'});
            else 
                response.status(500).json({erro: 400, msg: 'Erro interno no servidor'});
        }
    }

    public async obter_nome({response, auth}: HttpContextContract){
        try{
            await auth.use('api').authenticate();
            const user = auth.use('api').user;
            if(user != undefined){
                const cliente = await Cliente.findBy('id',user.clienteId);
                if(cliente != null){
                    response.status(200).json({nome: cliente.nome, email: user.email});
                }
            }
        }catch(erro){
            console.log(erro);
            if(erro.code === 'E_INVALID_API_TOKEN'){
                response.status(402).json({erro: 402 ,msg: 'Usuário não autenticado'});
            }else{
                response.status(500).json({erro: 500 , msg: 'Ocorreu um erro no servidor'});
            }
        }
    }

    public async logout({response, auth}: HttpContextContract){
        try {
            auth.use('api').authenticate();    
            auth.use('api').logout();
            response.status(200);
        } catch (error) {
            response.status(500);
        }
    }

    public async check({response}: HttpContextContract){
        response.status(200);
    }
}
