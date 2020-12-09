import { DateTime } from 'luxon'
import { BaseModel, column, hasOne, HasOne } from '@ioc:Adonis/Lucid/Orm'
import Estado from './Estado';

export default class Cidade extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public cidadeNome: String; 

  @hasOne(()=> Estado)
  public estado: HasOne<typeof Estado>

}
