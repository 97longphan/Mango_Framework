Pod::Spec.new do |spec|
  spec.name         = "Mango"
  spec.version      = "0.0.1"
  spec.platform     = :ios, "12.0"
  spec.swift_version = "5.0"
  spec.summary      = "A example framework"
  spec.homepage     = "https://github.com/97longphan/MangoFramework"
  spec.license      = { :type => 'BSD' }
  spec.author       = { "97longphan" => "97longphan@gmail.com" }
  spec.source       = { :git => "https://github.com/97longphan/MangoFramework", :tag => spec.version }
  spec.source_files  = "Source/*.{swift}"
end
