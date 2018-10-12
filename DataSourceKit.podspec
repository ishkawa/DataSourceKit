Pod::Spec.new do |s|
  s.name         = "DataSourceKit"
  s.version      = "0.2.0"
  s.summary      = "Declarative, testable data source of UICollectionView and UITableView"
  s.description  = <<-DESC
  Declarative, testable data source of UICollectionView and UITableView.
                   DESC
  s.homepage     = "https://github.com/ishkawa/DataSourceKit"
	s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Ishikawa, Yosuke" => "y@ishkawa.org" }
  
  s.platform     = :ios, "9.0"
	s.swift_version = '4.1'
  s.source       = { :git => "https://github.com/ishkawa/DataSourceKit.git", :tag => "#{s.version}" }
  s.source_files  = "DataSourceKit", "DataSourceKit/**/*.{h,m,swift}"
  s.public_header_files = "DataSourceKit/**/*.h"
end
