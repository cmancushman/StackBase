Pod::Spec.new do |s|
s.name              = 'StackBase'
s.version           = '1.0.1'
s.summary           = 'An Objective-C backend framework.'
s.homepage          = 'https://github.com/cmancushman/StackBaseFramework'

s.description      = 'StackBase, currently in its alpha stage, offers frontend programmers a backend framework they can utilize without ever using a different language. Built on a MySQL database, Objective-C programmers may run complex queries, upload large amounts of data, and customize SQL tables simply by using the methods this framework offers.'


s.author            = {'Chris' => 'christopher.cushman@richmond.edu'}
s.license           = { :type => 'MIT', :file => 'LICENSE' }

s.platform          = :ios, '4.0'
s.source            = { :http => 'https://s3-us-west-2.amazonaws.com/bucketboi/StackBase.zip' }

s.ios.deployment_target = '8.0'
s.ios.vendored_frameworks = 'StackBase.framework'
end
