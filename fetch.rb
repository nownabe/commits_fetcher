require "csv"
require "octokit"

organization_name = ARGV[0]
$stderr.puts "Start getting commits from #{organization_name}"

Octokit.auto_paginate = true

client = Octokit::Client.new(access_token: ENV.fetch("GITHUB_TOKEN"))

repositories = client.organization_repositories(organization_name, per_page: 100)
repositories.each_with_index do |repo, i|
  $stderr.puts "Fetching commits of #{repo.full_name} (#{i+1}/#{repositories.size})"
  client.commits(repo.full_name).each do |commit|
    /^:(?<emoji>[-+\w]+):\s+.+$/ =~ commit.commit.message
    puts [
      organization_name,
      repo.name,
      commit.sha,
      commit.commit.author.name,
      commit.commit.author.email,
      commit.commit.author.date.iso8601,
      commit.author&.login,
      commit.commit.committer.name,
      commit.commit.committer.email,
      commit.commit.committer.date.iso8601,
      commit.comitter&.login,
      commit.commit.message,
      emoji,
    ].to_csv
  end
rescue
end
