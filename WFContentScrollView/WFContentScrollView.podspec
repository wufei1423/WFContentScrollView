Pod::Spec.new do |s|
    s.name         = 'WFContentScrollView'
    s.version      = '1.0.0'
    s.summary      = 'WFContentScrollView'
    s.homepage     = 'https://github.com/wufei1423'
    s.license      = 'MIT'
    s.authors      = {'吴飞' => 'wufei1423@163.com'}
    s.platform     = :ios, '10.0'
    s.source       = {:git => 'https://github.com/wufei1423/WFContentScrollView.git', :tag => s.version}
    s.source_files = 'WFContentScrollView/WFContentScrollView/*.{h,m}'
    s.resources    = 'WFContentScrollView/WFContentScrollView/*.{jpeg,xcassets,bundle,xib,storyboard}'
    s.requires_arc = true
end
