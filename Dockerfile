# Use uma imagem base oficial do Ruby
FROM ruby:3.2

ENV LANG C.UTF-8
ENV APP_DIR /app
# Instale dependências do sistema
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Defina o diretório de trabalho
WORKDIR ${APP_DIR} 

# Copie o restante do código do aplicativo
COPY . .

# Instale as gems
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

# Exponha a porta que o aplicativo irá rodar
EXPOSE 3007

# Comando para iniciar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3007"]
