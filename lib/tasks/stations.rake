namespace :stations do
  desc 'Creates a cache of images base on station location' do
    Dir.mkdir(directory_name) unless File.exists?(directory_name)
  end
end