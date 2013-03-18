multiplyString = (str, num, sep)->
  unless num?
    throw 'num is required'
    
  sep = sep or ''
  retval = []
  while num-- > 0
    retval.push str
  retval.join(sep)

module.exports = class MongoSQL
  constructor: ()->
  parse: (query)->
    keys = [] # keys 
    ops  = [] # operators 
    phs  = [] # placeholders
    vals = [] # values
    
    for key, value of query
      if typeof value is 'string' or
         typeof value is 'number' or
         typeof value is 'boolean' or
         value instanceof Date
        keys.push key
        ops.push '='
        phs.push '?'
        vals.push value

      else if value instanceof Array
        keys.push key
        ops.push 'IN'
        phs.push "(#{multiplyString('?', value.length, ',')})"
        vals = vals.concat value
        
      else if value instanceof RegExp
        source = value.source
        if not source.match(/^\^/)
          source = '%'+source
        else
          source = source.replace(/^\^/, '')
        if not source.match(/\$$/)
          source = source+'%'
        else
          source = source.replace(/\$$/, '')
          
        keys.push key
        ops.push 'LIKE'
        phs.push '?'
        vals.push source
        
      else
        for op, val of value
          keys.push key
          ops.push op
          phs.push '?'
          vals.push val

    {
      where: ("#{keys[idx]} #{ops[idx]} #{phs[idx]}" for key, idx in keys).join ' AND '
      value: vals
    } 

unless module.parents?
  expect = require('chai').expect
  expect(multiplyString('hoge', 1, '')).to.be.equal 'hoge'
  expect(multiplyString('hoge', 2, '')).to.be.equal 'hogehoge'
  expect(multiplyString('hoge', 3, ',')).to.be.equal 'hoge,hoge,hoge'
  