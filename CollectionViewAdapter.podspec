Pod::Spec.new do |s|
  s.name                      = 'CollectionViewAdapter'
  s.version 		 	= '0.2.0'
  s.summary                   = 'A Swift based collection view binder for iOS 8 and up. Look like AdapterDelegates for RecyclerView on Android'
  s.platform                  = :ios, '8.0'
  s.homepage                  = 'https://github.com/DimaKorol/CollectionViewAdapter'
  s.license                   = { :type => 'MIT', :file => 'LICENSE' }
  s.author                    = { 'DzmitryiKaraliou' => 'karaliou.dzmitryi@gmail.com' }
  s.source                    = { :git => 'https://github.com/DimaKorol/CollectionViewAdapter.git', :tag => s.version }
  s.source_files              = 'CollectionViewAdapter/**/*.{h,swift}'
  s.framework 			= 'UIKit'
end
