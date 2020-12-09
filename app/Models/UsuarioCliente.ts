import { DateTime } from 'luxon'
import { BaseModel, column, hasOne, HasOne, belongsTo, BelongsTo } from '@ioc:Adonis/Lucid/Orm'
import ExceptionHandler from 'App/Exceptions/Handler'
import Cliente from './Cliente';
import Database from '@ioc:Adonis/Lucid/Database';
import {Md5} from "md5-typescript";

export default class UsuarioCliente extends BaseModel {
  public static table = 'usuario_cliente';

  @column({isPrimary: true ,columnName: 'cliente_id'})
  public clienteId:number;

  @column({columnName: 'usuario_cliente_email'})
  public email: String; 

  @column({columnName: 'usuario_cliente_senha'})
  public senha: String;

  @belongsTo(() => Cliente)
  public cliente: BelongsTo<typeof Cliente>;
  

  async registrarUsuario(dados): Promise<boolean>{
    const user = await UsuarioCliente.findBy('usuario_cliente_email', dados.usuario.email);
    if(user == null){
      try{
        const cliente = await Cliente.create(dados.cliente);
        const usuario_cliente = new UsuarioCliente();
        usuario_cliente.email = dados.usuario.email; 
        usuario_cliente.senha = Md5.init(dados.usuario.senha);
        usuario_cliente.clienteId = cliente.id;
        await usuario_cliente.related('cliente').associate(cliente);
        return true;
      }catch(error){
        return false;
        Database.rollbackGlobalTransaction();
      }
    }
    throw new Error('Já existe um perfil com essa conta');
  }
}
