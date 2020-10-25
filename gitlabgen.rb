require 'openssl'
require 'gitlab/license'





# Generate a key pair. You should do this only once.
#key_pair = OpenSSL::PKey::RSA.generate(2048)

# Write it to a file to use in the license generation application.
#File.open("license_key", "w") { |f| f.write(key_pair.to_pem) }

# Extract the public key.
#public_key = key_pair.public_key
# Write it to a file to ship along with the main application.
#File.open("license_key.pub", "w") { |f| f.write(public_key.to_pem) }

# In the license generation application, load the private key from a file.
private_key = OpenSSL::PKey::RSA.new File.read("license_key")
Gitlab::License.encryption_key = private_key

# Build a new license.
license = Gitlab::License.new

name = nil
company = nil
email = nil

# License information to be rendered as a table in the admin panel.
# E.g.: "This instance of GitLab Enterprise Edition is licensed to:"
# Specific keys don't matter, but there needs to be at least one.

#First we query the user for their info
puts "Please enter your name: "
name = gets.chomp
puts "Great, now your company name: "
company = gets.chomp
puts "Amazing! Lastly please input your email: "
email = gets.chomp

license.licensee = {
  "Name"    => name,
  "Company" => company,
  "Email"   => email
}

# The date the license starts. 
# Required.
license.starts_at         = Date.today


# Restrictions bundled with this license.
# Not required, to allow unlimited-user licenses for things like educational organizations.
license.restrictions = {
  :plan => "ultimate", 
  :id   => rand(1000..99999999)
}

# Export the license, which encrypts and encodes it.
data = license.export

puts "Exported license:"
puts data
puts "Don't forget to replace the public key in /opt/gitlab/embedded/service/gitlab-rails/.license_encryption_key.pub! Good luck!"