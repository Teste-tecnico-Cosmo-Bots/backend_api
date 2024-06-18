# Use a imagem base com Ruby 3.1.6
FROM ruby:3.1.6

# Instale dependências
RUN apt-get update -qq && apt-get install -y nodejs sqlite3
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y yarn

# Configure o diretório de trabalho
WORKDIR /myapp

# Adicione o Gemfile e Gemfile.lock
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Instale as gems
RUN bundle install

# Adicione o resto do código da aplicação
COPY . /myapp

# Precompile os assets (opcional)
#RUN bundle exec rake assets:precompile

# Execute as migrações do banco de dados
RUN bundle exec rake db:migrate

# Exponha a porta da aplicação
EXPOSE 3000

# Comando para rodar a aplicação
CMD ["rails", "server", "-b", "0.0.0.0"]
