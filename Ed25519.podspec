Pod::Spec.new do |s|
  s.name             = 'Ed25519'
  s.version          = '0.2.0'
  s.summary          = 'Ed25519 for Swift 4'
  s.homepage         = 'https://github.com/vzsg/ed25519'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Zsolt Váradi'
  s.source           = { :git => 'https://github.com/vzsg/ed25519.git', :tag => s.version.to_s }

  s.pod_target_xcconfig = { 'SWIFT_WHOLE_MODULE_OPTIMIZATION' => 'YES',
                            'APPLICATION_EXTENSION_API_ONLY' => 'YES' }

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.source_files = 'Sources/Ed25519/**/*.swift'

  s.dependency 'libCEd25519', '~> 0.2.0'
end
