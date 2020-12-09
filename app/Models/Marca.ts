import { DateTime } from 'luxon'
import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'

export default class Marca extends BaseModel {
  public static table = 'marca';

  @column({ isPrimary: true, columnName: 'id' })
  public id: number;

  @column({columnName: 'marca_nome'})
  public nome: String; 

  @column.dateTime({ autoCreate: true })
  public datacriacao: DateTime;

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public dataatualizacao: DateTime;
}
