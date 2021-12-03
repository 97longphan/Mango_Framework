Pod::Spec.new do |spec|
  spec.name         = 'MangoMango'
  spec.version      = '0.1.2'
  spec.platform     = :ios, '13.0'
  spec.swift_version = '5.0'
  spec.summary      = 'A example framework'
  spec.homepage     = 'https://github.com/97longphan/MangoFramework'
  spec.license      = { :type => 'MIT', :text => <<-LICENSE
                   	Copyright 2012
                   	Permission is granted to...
                 	LICENSE
               	     }
  spec.author       = { '97longphan' => '97longphan@gmail.com' }
  spec.source       = { :git => 'https://github.com/97longphan/MangoFramework.git', :tag => spec.version }

  #source	
  spec.resources     = 'Resource/*'
  spec.source_files  = 'Source/**/*'
  
  #dependency
  spec.dependency 'RxSwift'
  spec.dependency 'RxCocoa'
  spec.dependency 'Action'
  spec.dependency 'RxSwiftExt', '~> 5'
  spec.dependency 'Alamofire', '~> 5.4'
  spec.dependency 'Nuke'
  spec.dependency 'SnapKit', '~> 5.0.0'

end
