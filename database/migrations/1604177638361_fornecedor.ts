import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class Fornecedor extends BaseSchema {
  protected tableName = 'fornecedor'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.string('fornecedor_nome').notNullable()
      table.string('fornecedor_cnpj').notNullable()
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}
