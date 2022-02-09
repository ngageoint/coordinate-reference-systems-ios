Pod::Spec.new do |s|
  s.name             = 'crs-ios'
  s.version          = '1.0.3'
  s.license          =  {:type => 'MIT', :file => 'LICENSE' }
  s.summary          = 'iOS SDK for Coordinate Reference Systems'
  s.homepage         = 'https://github.com/ngageoint/coordinate-reference-systems-ios'
  s.authors          = { 'NGA' => '', 'BIT Systems' => '', 'Brian Osborn' => 'bosborn@caci.com' }
  s.social_media_url = 'https://twitter.com/NGA_GEOINT'
  s.source           = { :git => 'https://github.com/ngageoint/coordinate-reference-systems-ios.git', :tag => s.version }
  s.requires_arc     = true

  s.platform         = :ios, '12.0'
  s.ios.deployment_target = '12.0'

  s.source_files = 'crs-ios/**/*.{h,m}'

  s.frameworks = 'Foundation'
end
