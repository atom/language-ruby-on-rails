describe "Ruby on Rails package", ->
  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-ruby-on-rails")

  it "parses the HTML grammar", ->
    grammar = atom.grammars.grammarForScopeName("text.html.ruby")
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "text.html.ruby"

  it "parses the JavaScript grammar", ->
    grammar = atom.grammars.grammarForScopeName("source.js.rails source.js.jquery")
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.js.rails source.js.jquery"

  it "parses the RJS grammar", ->
    grammar = atom.grammars.grammarForScopeName("source.ruby.rails.rjs")
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.ruby.rails.rjs"

  it "parses the Rails grammar", ->
    grammar = atom.grammars.grammarForScopeName("source.ruby.rails")
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.ruby.rails"

  it "parses the SQL grammar", ->
    grammar = atom.grammars.grammarForScopeName("source.sql.ruby")
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.sql.ruby"


  describe 'inline sql', ->
    it 'tokenizes the content inside where string queries as SQL', ->
      grammar = atom.grammars.grammarForScopeName("source.ruby.rails")
      lines = grammar.tokenizeLines '''
        Post.where('created_at IS NOT NULL created_at > ?', Time.now)
      '''

      expect(lines[0][2]).toEqual value: 'created_at IS NOT NULL created_at > ?', scopes: ['source.ruby.rails', 'meta.rails.query_methods.sql']


    it 'tokenizes the content inside order string queries as SQL', ->
      grammar = atom.grammars.grammarForScopeName("source.ruby.rails")
      lines = grammar.tokenizeLines '''
        Post.order("case when sticky = 'yes' then 1 else 0 end desc, created desc")
      '''
      expect(lines[0][2]).toEqual value: "case when sticky = 'yes' then 1 else 0 end desc, created desc", scopes: ['source.ruby.rails', 'meta.rails.query_methods.sql']
