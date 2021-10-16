class SetUpUITests
    def setUpUITests s
        specname = format('%{nm}%{tp}', nm: s.name, "UITests")
        basedirs = "InterviewUITests"
        dirs = format("{%{bs},%{nm}}", bs: basedirs, nm: name)

        s.test_spec specname do |ts|
          ts.test_type = :ui
          ts.source_files = [format('UITests/%{dirs}/**/*.swift', dirs: dirs),
                             'UITests/InterviewUITests/**/*.swift']

          ts.resource_bundle = { format('com.stepstone.Core.%{nm}', nm: specname) => [format('UITests/%{dirs}/**/*.{plist,json,lproj,strings,js,html}', dirs: dirs)] }

          ts.dependency 'Criollo'
          ts.dependency 'Utils'
          ts.dependency 'TestKit'
        end
    end
end
