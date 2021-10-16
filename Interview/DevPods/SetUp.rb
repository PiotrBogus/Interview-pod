class SetUp
    def setUp s
        s.version      = "1.0"
        s.homepage     = "https://piotrbogus.com"
        s.summary      = s.name
        s.license      =  "Copyright (C) 2020-2021 PiotrBogus"
        s.authors      = { "PiotrBogus" => "piotrbogus@piotrbogus.com" }
        s.platform     = :ios, '14.1'
        s.source       = { :git => "git@github.com:PiotrBogus/Interview-pod.git", :tag => s.version }
        s.swift_version = "5.4"
    end
    
    def excludeArm64 s
        exclarch = `../scripts/exclarch.sh`.chomp()
        
        if exclarch != ""
            s.xcconfig = {
                'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => exclarch
            }
        end
    end
end
