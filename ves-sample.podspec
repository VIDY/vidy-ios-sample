Pod::Spec.new do |spec|
  spec.name         = 'ves-sample'
  spec.version      = '0.1.3'
  spec.license      = { :type => 'Copyright (C) 2018 Vidy, Inc - All Rights Reserved', :file => 'LICENSE' }
  spec.summary      = 'VDYEmbedSDK sample'
  spec.homepage     = 'https://github.com/VIDY/vidy-ios-sample'
  spec.source       = { :http => 'https://github.com/VIDY/vidy-ios-sample/raw/master/VDYEmbedSDK-sample-0.1.3.zip' }
  spec.authors      = { 'Arria Owlia' => 'arriaowlia@gmail.com' }
  spec.platform     = :ios
  spec.ios.deployment_target    = '10.0'
  spec.ios.vendored_frameworks  = 'VDYEmbedSDK.framework'
end