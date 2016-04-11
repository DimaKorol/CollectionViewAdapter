Pod::Spec.new do |s|
  s.name                      = "CollectionViewAdapter"
  s.summary                   = 'A Swift based collection view binder for iOS 8 and up. Look like AdapterDelegates
                                for RecyclerView on Android'
  s.homepage                  = 'https://github.com/DimaKorol/CollectionViewAdapter'
  s.license                   = 'MIT'
  s.author                    = { "DzmitryiKaraliou" => "toxicgen151@gmail.com" }
  s.platform                  = :ios, '8.0'
  s.ios.deployment_target     = '8.0'
  s.requires_arc              = true
  s.source                    = { :git => 'https://github.com/DimaKorol/CollectionViewAdapter.git', :tag => s.version.to_s }
  s.source_files              = 'CollectionViewAdapter/**/*.{h,swift}'
  s.resources                 = 'CollectionViewAdapter/*.xcassets'
  s.framework = "UIKit"
end
