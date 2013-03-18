MongoSQL = require '../src/MongoSQL'
expect = require('chai').expect

describe 'MongoSQL', ->
  describe 'create instance', ->
    mongosql = null
    it 'create instance', ->
      mongosql = new MongoSQL()
      expect(mongosql).to.be.an.instanceof MongoSQL
  describe 'parse query', ->
    mongosql = new MongoSQL()
    it 'parse query number', ->
      expect(mongosql.parse({age: 33})).to.deep.equal
        where: "age = ?"
        value: [33]
      
    it 'parse query string', ->
      expect(mongosql.parse({name: 'hoge'})).to.deep.equal
        where: 'name = ?'
        value: ["hoge"]
      
    it 'parse query boolean', ->
      expect(mongosql.parse({isOk: true})).to.deep.equal
        where: 'isOk = ?'
        value: [true]
      expect(mongosql.parse({isOk: false})).to.deep.equal
        where: 'isOk = ?'
        value: [false]
      
    it 'parse query Date', ->
      expect(mongosql.parse({begin: new Date(2012, 0, 1)})).to.deep.equal
        where: 'begin = ?'
        value: [new Date(2012, 0, 1)]
      
    it 'parse query RegExp', ->
      expect(mongosql.parse({name: /muddy/})).to.deep.equal
        where: 'name LIKE ?'
        value: ['%muddy%']
      expect(mongosql.parse({name: /^muddy/})).to.deep.equal
        where: 'name LIKE ?'
        value: ['muddy%']
      expect(mongosql.parse({name: /muddy$/})).to.deep.equal
        where: 'name LIKE ?'
        value: ['%muddy']
      expect(mongosql.parse({name: /^muddy$/})).to.deep.equal
        where: 'name LIKE ?'
        value: ['muddy']
      
    it 'parse query Array', ->
      expect(mongosql.parse({age: [1, 2, 5]})).to.deep.equal
        where: 'age IN (?,?,?)'
        value: [1,2,5]

    it 'parse query comaparison number', ->
      expect(mongosql.parse({begin: {'>': new Date(2012, 0, 1)}})).to.deep.equal
        where: 'begin > ?'
        value: [new Date(2012, 0, 1)]
      
    it 'parse query multiple condition number and string', ->
      expect(mongosql.parse({age: 1, name: 'muddydixon'})).to.deep.equal
        where: 'age = ? AND name = ?'
        value: [1, 'muddydixon']
        
    it 'parse query multiple condition number, string and Date', ->
      expect(mongosql.parse({age: 1, name: 'muddydixon', begin: new Date(2013, 0, 1)})).to.deep.equal
        where: 'age = ? AND name = ? AND begin = ?'
        value: [1, 'muddydixon', new Date(2013, 0, 1)]
      
    it 'parse query multiple condition string and Number Array', ->
      expect(mongosql.parse({name: 'muddydixon', age: [1, 2, 3]})).to.deep.equal
        where: 'name = ? AND age IN (?,?,?)'
        value: ['muddydixon', 1, 2, 3]
    
      
