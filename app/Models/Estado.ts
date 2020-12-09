import { DateTime } from 'luxon'
import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'

export default class Estado extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public estadoNome: String;

  @column()
  public estadoUf: String;
}
