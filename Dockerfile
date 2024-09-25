# Use uma imagem base oficial do Ruby
FROM ruby:3.2

# Instale dependências do sistema
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Defina o diretório de trabalho
WORKDIR /app

# Copie o Gemfile e o Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instale as gems
RUN bundle install

# Copie o restante do código do aplicativo
COPY . .

# Exponha a porta que o aplicativo irá rodar
EXPOSE 3007

# Comando para iniciar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3007"]
