# On some OSes+py3, /usr/bin/pip3 does not have a /usr/bin/pip link/file
# and Inspec fails to correctly find the pip binary.
# As there's no py2/py3 separate tools, this hack let's us overcome the issue

if(File.exist?('/usr/bin/pip3'))
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
