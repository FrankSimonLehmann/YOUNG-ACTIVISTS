namespace :demonstration do
  desc "emit the string"
  task emitstring: :environment do
    Demonstration.all.each do |demo|
      demo.title = demo.title.gsub(/"/, '')
    end
  end
end
