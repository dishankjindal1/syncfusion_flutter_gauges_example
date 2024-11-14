make reset:
	dart format .
	flutter clean
	flutter pub get
	make br

br:
	dart run build_runner build -d

brw:
	make br
	dart run build_runner watch

abb:
	flutter build appbundle --dart-define-from-file=.env

apk:
	flutter build apk --dart-define-from-file=.env
	firebase appdistribution:distribute build/app/outputs/apk/release/app-release.apk --app 1:357584911868:android:5c4c395768a9ad571ec679 --groups tester

podinstall:
	cd ios; rm -rf .symlinks; rm -rf Pods; rm Podfile.lock; pod install --repo-update; cd ..
