import { DateTime } from 'luxon'
import { BaseModel, column, manyToMany, ManyToMany } from '@ioc:Adonis/Lucid/Orm'
import Endereco from './Endereco';
import Database from '@ioc:Adonis/Lucid/Database'
import UsuarioCliente from './UsuarioCliente';
import Veiculo from './Veiculo';

export default class Cliente extends BaseModel {
  public static table = 'cliente';
  
  @column({ isPrimary: true, columnName: 'id'})
  public id: number;

  @column({columnName: 'cliente_nome'})
  public nome: String;

  @column({columnName: 'cliente_cpf'})
  public cpf: String;

  @column.date({columnName: 'cliente_datanascimento'})
  public datanascimento: DateTime;

  @column({columnName: 'cliente_sexo'})
  public sexo: String;

  @column({columnName: 'cliente_telefone'})
  public telefone: String; 

  @column({columnName: 'cliente_celular'})
  public celular: String;

  @manyToMany(()=> Endereco, {
    pivotTable: 'endereco_cliente'
  })
  public enderecos: ManyToMany<typeof Endereco>;

  @manyToMany(()=> Veiculo, {
    pivotTable: 'veiculo_cliente'
  })
  public veiculos: ManyToMany<typeof Veiculo>;

  @column.dateTime({ autoCreate: true, columnName: 'cliente_dataregistro' })
  public dataRegistro: DateTime;

  @column.dateTime({ autoCreate: true, autoUpdate: true , columnName: 'cliente_dataatualizacao'})
  public dataAtualizacao: DateTime;


  async atualizar_cliente(data):Promise<boolean>{
    try{
      const user= await UsuarioCliente.findBy('usuario_cliente_email', data.usuario.email);
      if(user != null){
        console.log(user);

        const cliente = await Cliente.find(user.clienteId); 
        /*cliente.nome = data.cliente.nome; 
        cliente.cpf = data.cliente.cpf;
        cliente.celular = data.cliente.celular; 
        cliente.datanascimento = data.cliente.datanascimento; 
        cliente.sexo = data.cliente.sexo; 
        clente.telefone = data.cliente.telefone;*/

        if(cliente != null){
          cliente.merge(data.cliente);
          await cliente.save();
        }

        return true;
      }
      throw new Error('Cliente não cadastrado');
    }catch(error){
      throw new Error(error);
    }
  }
}
