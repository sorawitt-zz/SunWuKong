Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "SunWuKong"
s.summary = "SunWuKong lets a user select an ice cream flavor."
s.requires_arc = true

# 2
s.version = "0.0.1"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Sorawit Trutsat" => "sorawit.tr@gmail.com" }

# For example,
# s.author = { "Joshua Greene" => "jrg.developer@gmail.com" }


# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/sorawitt/SunWuKong"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/sorawitt/SunWuKong.git", :tag => "#{s.version}"}

# For example,
# s.source = { :git => "https://github.com/JRG-Developer/RWPickFlavor.git", :tag => "#{s.version}"}


# 7
s.dependency 'Firebase/Core'
s.dependency 'Firebase/Storage'

# 8
s.source_files = "SunWuKong/**/*.{h, swift}"

# 9
# s.resources = "RWPickFlavor/**/*.{png,jpeg,jpg,storyboard,xib}"
end
