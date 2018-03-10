class Build
  class << self
    def run!
      rake(*tasks)
    end

    def tasks
      ['rake db:schema:load RAILS_ENV=test > /dev/null',
       'rubocop',
       'rspec']
    end

    def rake(*tasks)
      tasks.each do |task|
        cmd = if task.include?('bundle exec')
                task
              else
                "bundle exec #{task}"
              end
        puts "Running command: #{cmd}"
        return false unless system(cmd)
      end
      true
    end
  end
end

#-----------------------------------------------------------------------------------------------------------------------
# Script starts here
#-----------------------------------------------------------------------------------------------------------------------

result = Build.run!

failures = result == false

if failures
  puts 'Museum build FAILED'
  exit(false)
else
  puts 'Museum build finished successfully'
  exit(true)
end
