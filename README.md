commits_fetcher
===============

```
bundle install

export GITHUB_TOKEN=xxxx
bundle exec ruby fetch.rb myorg > result.csv
```

Store commits to Elasticsearch

```
bundle exec ruby put.rb myorg
```
