describe "Ruby on Rails package", ->
  grammar= null
  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-ruby-on-rails")

  it "parses the HTML grammar", ->
    grammar = atom.grammars.grammarForScopeName("text.html.ruby")
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "text.html.ruby"

  describe 'HTML ERB tags', ->
    beforeEach ->
      waitsForPromise ->
        atom.packages.activatePackage('language-ruby-on-rails')

    it 'tokenizes the <% %>', ->
      lines = grammar.tokenizeLines '''
        <% foo = 10 %>
      '''

      expect(lines[0][0]).toEqual value: '<%', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[0][1]).toEqual value: ' foo = 10 ', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html']
      expect(lines[0][2]).toEqual value: '%>', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']

    it 'tokenizes the <%= %>', ->
      lines = grammar.tokenizeLines '''
        <%= foo %>
      '''

      expect(lines[0][0]).toEqual value: '<%=', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[0][1]).toEqual value: ' foo ', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html']
      expect(lines[0][2]).toEqual value: '%>', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']

    it 'tokenizes the <%= %> in string', ->
      lines = grammar.tokenizeLines '''
        '<%= foo %>'
        "<%= bar %>"
      '''
      expect(lines[0][0]).toEqual value: "'", scopes: ['text.html.ruby']
      expect(lines[0][1]).toEqual value: '<%=', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[0][2]).toEqual value: ' foo ', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html']
      expect(lines[0][3]).toEqual value: '%>', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[0][4]).toEqual value: "'", scopes: ['text.html.ruby']
      expect(lines[1][0]).toEqual value: '"', scopes: ['text.html.ruby']
      expect(lines[1][1]).toEqual value: '<%=', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[1][2]).toEqual value: ' bar ', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html']
      expect(lines[1][3]).toEqual value: '%>', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[1][4]).toEqual value: '"', scopes: ['text.html.ruby']

    it 'tokenizes the <%= %> in string in HTML tag', ->
      lines = grammar.tokenizeLines '''
        <div class='<%= foo %>'>
        <div class="<%= bar %>">
        <div class= '<%= foo %>'>
        <div class= "<%= bar %>">

      '''
      expect(lines[0][0]).toEqual value: "<div class='", scopes: ['text.html.ruby']
      expect(lines[0][1]).toEqual value: '<%=', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[0][2]).toEqual value: ' foo ', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html']
      expect(lines[0][3]).toEqual value: '%>', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[0][4]).toEqual value: "'>", scopes: ['text.html.ruby']
      expect(lines[1][0]).toEqual value: '<div class="', scopes: ['text.html.ruby']
      expect(lines[1][1]).toEqual value: '<%=', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[1][2]).toEqual value: ' bar ', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html']
      expect(lines[1][3]).toEqual value: '%>', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[1][4]).toEqual value: '">', scopes: ['text.html.ruby']
      expect(lines[2][0]).toEqual value: "<div class= '", scopes: ['text.html.ruby']
      expect(lines[2][1]).toEqual value: '<%=', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[2][2]).toEqual value: ' foo ', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html']
      expect(lines[2][3]).toEqual value: '%>', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[2][4]).toEqual value: "'>", scopes: ['text.html.ruby']
      expect(lines[3][0]).toEqual value: '<div class= "', scopes: ['text.html.ruby']
      expect(lines[3][1]).toEqual value: '<%=', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[3][2]).toEqual value: ' bar ', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html']
      expect(lines[3][3]).toEqual value: '%>', scopes: ['text.html.ruby', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[3][4]).toEqual value: '">', scopes: ['text.html.ruby']



  it "parses the JavaScript grammar", ->
    grammar = atom.grammars.grammarForScopeName("source.js.rails source.js.jquery")
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.js.rails source.js.jquery"

  describe 'HTML ERB tags', ->
    beforeEach ->
      waitsForPromise ->
        atom.packages.activatePackage('language-ruby-on-rails')

    it 'tokenizes the <% %>', ->
      lines = grammar.tokenizeLines '''
        <% foo = 10 %>
      '''

      expect(lines[0][0]).toEqual value: '<%', scopes: ['source.js.rails source.js.jquery', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[0][1]).toEqual value: ' foo = 10 ', scopes: ['source.js.rails source.js.jquery', 'source.ruby.rails.embedded.html']
      expect(lines[0][2]).toEqual value: '%>', scopes: ['source.js.rails source.js.jquery', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']

    it 'tokenizes the <%= %>', ->
      lines = grammar.tokenizeLines '''
        <%= foo %>
      '''

      expect(lines[0][0]).toEqual value: '<%=', scopes: ['source.js.rails source.js.jquery', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[0][1]).toEqual value: ' foo ', scopes: ['source.js.rails source.js.jquery', 'source.ruby.rails.embedded.html']
      expect(lines[0][2]).toEqual value: '%>', scopes: ['source.js.rails source.js.jquery', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']

    it 'tokenizes the <%= %> in string', ->
      lines = grammar.tokenizeLines '''
        '<%= foo %>'
        "<%= bar %>"
      '''
      expect(lines[0][0]).toEqual value: "'", scopes: ['source.js.rails source.js.jquery']
      expect(lines[0][1]).toEqual value: '<%=', scopes: ['source.js.rails source.js.jquery', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[0][2]).toEqual value: ' foo ', scopes: ['source.js.rails source.js.jquery', 'source.ruby.rails.embedded.html']
      expect(lines[0][3]).toEqual value: '%>', scopes: ['source.js.rails source.js.jquery', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[0][4]).toEqual value: "'", scopes: ['source.js.rails source.js.jquery']
      expect(lines[1][0]).toEqual value: '"', scopes: ['source.js.rails source.js.jquery']
      expect(lines[1][1]).toEqual value: '<%=', scopes: ['source.js.rails source.js.jquery', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[1][2]).toEqual value: ' bar ', scopes: ['source.js.rails source.js.jquery', 'source.ruby.rails.embedded.html']
      expect(lines[1][3]).toEqual value: '%>', scopes: ['source.js.rails source.js.jquery', 'source.ruby.rails.embedded.html', 'punctuation.section.embedded.ruby']
      expect(lines[1][4]).toEqual value: '"', scopes: ['source.js.rails source.js.jquery']

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
