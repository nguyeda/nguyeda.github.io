FROM ruby:2.7-alpine as jekyll

WORKDIR /app

RUN apk add --no-cache build-base gcc bash cmake git gcompat
RUN gem install bundler jekyll

COPY . .

ENTRYPOINT ["jekyll"]
CMD [ "--help" ]

#####
FROM jekyll as serve

EXPOSE 4000

ENTRYPOINT [ "./docker-entrypoint.sh" ]
CMD [ "bundle", "exec", "jekyll", "serve", "--force_polling", "-H", "0.0.0.0", "-P", "4000" ]

