class Build
  TASKS = ['rake db:schema:load RAILS_ENV=test > /dev/null',
           'bundle audit',
           'rubocop',
           'rspec',
           'cucumber'].freeze
  class << self
    def success?
      TASKS.each do |task|
        cmd = task.include?('xvfb-run -a bundle exec') ? task : "xvfb-run -a bundle exec #{task}"
        puts "Running command: #{cmd}"
        return false unless system(cmd)
      end
      true
    end
  end
end

if Build.success?
  puts 'Museum build finished successfully'
  exit(true)
else
  puts 'Museum build FAILED'
  exit(false)
end
