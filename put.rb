require "csv"
require "json"

def make_json(row)
  {
    organization: row[0],
    repository: row[1],
    sha: row[2],
    author_name: row[3],
    author_email: row[4],
    author_timestamp: row[5],
    author_login: row[6],
    committer_name: row[7],
    committer_email: row[8],
    committer_timestamp: row[9],
    committer_login: row[10],
    message: row[11],
    emoji: row[12],
  }.to_json
end

organization_name = ARGV[0]

CSV.open("result.csv", "r") do |f|
  f.each_with_index do |row, i|
    cmd = "curl -XPUT 'http://localhost:9200/#{organization_name}/commits/#{i}' -d '#{make_json(row)}' -H 'Content-Type: application/json'"
    puts "#{cmd}"
    system(cmd)
  end
end
