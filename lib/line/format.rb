formats_path = File.join(Rails.root.to_s, 'lib', 'line', 'formats')
%w[base message action template].each { |file| require File.join(formats_path, file)}
%w[messages actions templates].each do |dir|
  Dir.each_child(File.join(formats_path, dir)) do |file|
    require File.join(formats_path, dir, file)
  end
end
