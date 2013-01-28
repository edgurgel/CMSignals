Pod::Spec.new do |s|
  s.name         = "CMSignals"
  s.version      = "1.0.0"
  s.summary      = "Qt Signals and Slots clone to Objective-C."
  s.homepage     = "https://github.com/edgurgel/CMSignals"
  s.license      = 'MIT'
  s.author       = { "Eduardo Gurgel" => "eduardo.gurgel@codeminer42.com", "Tiago Bastos" => "tiago.bastos@codeminer42.com" }
  s.source       = { :git => "https://github.com/edgurgel/CMSignals.git", :tag => "1.0.0" }
  s.source_files = './CMSignals/*.{h,m}'
end
