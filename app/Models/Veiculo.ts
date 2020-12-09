import { DateTime } from 'luxon'
import { BaseModel, column, belongsTo, BelongsTo } from '@ioc:Adonis/Lucid/Orm'
import Marca from './Marca';

export default class Veiculo extends BaseModel {
  public static table = 'veiculo';

  @column({ isPrimary: true, columnName: 'id'})
  public id: number;

  @column({columnName: 'veiculo_nome'})
  public nome: String; 

  @column({columnName: 'veiculo_anofabricacao'})
  public anofabricacao: number; 
  
  @column({columnName: 'veiculo_quilometragem'})
  public quilometragem: number; 

  @column({columnName: 'veiculo_ativo'})
  public ativo: boolean;

  @column({columnName: 'marca_id'})
  public marcaId: number; 

  @belongsTo(()=> Marca)
  public marca: BelongsTo<typeof Marca>

}
