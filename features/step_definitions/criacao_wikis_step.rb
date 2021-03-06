Dado "nenhum registro anterior de wiki" do
  Wiki.delete_all
end

Quando "recebo uma requisição de leitura da Wiki {string}" do |name|
  put '/wikis', {
    readingtime: {
      wiki: {
        name: name,
      }
    }
  }
end

Então "a resposta deve conter o registro da Wiki {string}" do |name|
  the_json = %({ "wiki": { "name": "#{name}" } })
  last_json.should be_json_eql(the_json).excluding("readings")
end

Então "a resposta deve conter um contagem de leitura igual a 1" do
  last_json.should have_json_size(1).at_path("wiki/readings")
end


Dado "o usuário na página principal da aplicação" do
  visit "/"
end

Então "ele visualiza uma tabela contendo os nomes e as contagens de leitura das wikis registradas" do
  page.should have_selector "th[data-ccb=name]"
  page.should have_selector "th[data-ccb=count]"
end
