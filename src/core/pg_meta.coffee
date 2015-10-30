utils =  require('./utils')

table_exists = (plv8, table_name)->
  schema = utils.current_schema(plv8)
  # utils.memoize plv8, table_name, ()->
  result = utils.exec plv8,
    select: [':true']
    from: ['$q', 'information_schema', 'tables']
    where: {table_name: table_name, table_schema: schema}
  result.length > 0

exports.table_exists = table_exists

index_exists = (plv8, table_name)->
  schema = utils.current_schema(plv8)
  # utils.memoize plv8, table_name, ()->
  result = utils.exec plv8,
    select: [':true']
    from: [':pg_indexes']
    where: ['$and', ['$eq', ':indexname::text', table_name],
                    ['$eq', ':schemaname::text', schema]]

  result.length > 0

exports.index_exists = index_exists
