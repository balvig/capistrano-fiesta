namespace :fiesta do
  desc 'Generate a release report for pasting in Slack'
  task :report do
    last_release = nil
    on roles(:web) do
      releases = capture("ls #{releases_path}")
      last_release ||= releases.split("\n").sort.last
    end
    Capistrano::Fiesta::Report.new(repo_url, last_release: last_release).run if last_release
  end
end

# after 'deploy:finished', 'fiesta:report'
