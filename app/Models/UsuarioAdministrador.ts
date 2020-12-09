import { DateTime } from 'luxon'
import { BaseModel, column, belongsTo, BelongsTo, hasOne, HasOne } from '@ioc:Adonis/Lucid/Orm'
import Administrador from './Administrador';

export default class UsuarioAdministrador extends BaseModel {
  public static table = 'usuario_administrador';

  @column({ isPrimary: true, columnName: 'administrador_id'})
  public administradorId: number; 

  @column({columnName: 'usuario_administrador_ativo'})
  public ativo: boolean;

  @column({isPrimary: true, columnName: 'usuario_administrador_usuario'})
  public usuario: String; 

  @column({columnName: 'usuario_administrador_senha'})
  public senha: String; 

  @column({columnName: 'usuario_administrador_nivel'})
  public nivel: number;

  @belongsTo(() => Administrador)
  public administrador: BelongsTo<typeof Administrador> 

}
