# On some OSes+py3, /usr/bin/pip3 does not have a /usr/bin/pip link/file
# and Inspec fails to correctly find the pip binary.
# We can probably pass the suite's name as an attribute to inspec
# but can't find how to do that so this flaky hack let's us overcome the issue
# Please, please please, feel free to improve it :)
if command('/usr/bin/pip3').exist?
  pip_binary = '/usr/bin/pip3'
else
  pip_binary = '/usr/bin/pip'
end

### WANTED/REQUIRED
case os[:name]
when 'fedora', 'opensuse'
  wanted_pips = []
else
  wanted_pips = %w{
    shuft
    attrs
  }
end

control 'Wanted/Required python packages' do
  title 'should be installed'

  wanted_pips.each do |p|
    describe pip(p, pip_binary) do
      it { should be_installed }
    end
  end
end

### UNWANTED
control 'Unwanted python packages' do
  title 'should be uninstalled'
  %w{
    campbel
    reverse_geocode
    indy-crypto
  }.each do |p|
    describe pip(p, pip_binary) do
      it { should_not be_installed }
    end
  end
end
