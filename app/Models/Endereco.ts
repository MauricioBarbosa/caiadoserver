import { DateTime } from 'luxon'
import { BaseModel, column, hasOne, HasOne } from '@ioc:Adonis/Lucid/Orm'
import Cidade from './Cidade';

export default class Endereco extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public logradouro: String; 

  @column()
  public bairro: String;

  @column()
  public cep: String; 

  @hasOne(() => Cidade)
  public cidade:HasOne<typeof Cidade>;

  
}
