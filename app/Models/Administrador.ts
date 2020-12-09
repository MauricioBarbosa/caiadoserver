import { DateTime } from 'luxon'
import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'

export default class Administrador extends BaseModel {
  public static table = 'administrador'

  @column({ isPrimary: true, columnName: 'id' })
  public id: number;

  @column({columnName: 'administrador_nome'})
  public nome: String; 

  @column({columnName: 'administrador_cpf'})
  public cpf: String; 

  @column({columnName: 'administrador_sexo'})
  public sexo: String; 

  @column.date({columnName: 'administrador_datanascimento'})
  public datanascimento: DateTime;

  @column({columnName: 'administrador_telefone'})
  public telefone: String;

  @column({columnName: 'administrador_celular'})
  public celular: String;

  @column({columnName: 'administrador_email'})
  public email: String;

  @column.dateTime({ autoCreate: true, columnName: 'administrador_createdAt'})
  public createdAt: DateTime;

  @column.dateTime({ autoCreate: true, autoUpdate: true, columnName: 'administrador_updatedAt' })
  public updatedAt: DateTime;
}
