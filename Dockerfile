FROM ruby:3.2.2

# Node.js と Yarn のバージョンを指定してインストール
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install --global yarn

RUN apt-get install -y g++ make libmariadb-dev

RUN mkdir -p /var/www/Bulsup

WORKDIR /var/www/Bulsup

ENV RAILS_ENV=production

# secret_key_baseを環境変数として受け入れる
ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE=${SECRET_KEY_BASE}

COPY Gemfile /var/www/Bulsup/Gemfile
COPY Gemfile.lock /var/www/Bulsup/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . /var/www/Bulsup

RUN RAILS_ENV=production bundle exec rake assets:precompile