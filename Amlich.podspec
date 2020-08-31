Pod::Spec.new do |spec|

spec.name           = "Amlich"
spec.version        = "1.1.2"
spec.summary        = "Amlich is a Swift package that provides an interface to convert date from Solar to Lunar and vice-versa."

spec.homepage       = "https://github.com/anhmv/Amlich"
spec.license        = { :type => "MIT", :file => "LICENSE" }
spec.author         = { "Anh Mac" => "anhmv91@gmail.com" }
spec.swift_version  = "5.2"
spec.source         = { :git => "https://github.com/anhmv/Amlich.git", :tag => "v#{spec.version}" }

spec.ios.deployment_target = "8.0"
spec.osx.deployment_target = "10.10"
spec.watchos.deployment_target = "2.0"
spec.tvos.deployment_target = "9.0"

spec.source_files = 'Sources/**/*.swift'
spec.swift_versions = ['4.0', '4.2', '5.0', '5.1']

end
