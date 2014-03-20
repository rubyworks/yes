
QED.configure :cov do
  require 'simplecov'
  SimpleCov.start do
    coverage_dir 'log/coverage'
    #add_group "Shared" do |src_file|
    #  /lib\/dotruby\/v(\d+)(.*?)$/ !~ src_file.filename
    #end
    #add_group "Revision 0", "lib/dotruby/v0"
  end
end

