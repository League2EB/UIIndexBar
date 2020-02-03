Pod::Spec.new do |s|
  s.name             = 'UIIndexBar'
  s.version          = '1.0.0'
  s.summary          = 'A short description of UIIndexBar.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/League2EB/UIIndexBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'League2EB' => 'poloa51404@gmail.com' }
  s.source           = { :git => 'https://github.com/League2EB/UIIndexBar.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  s.source_files = 'UIIndexBar/Classes/**/*'
  
  # s.resource_bundles = {
  #   'UIIndexBar' => ['UIIndexBar/Assets/*.png']
  # }
  
end
