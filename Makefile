# Mark a target as phony. That means a target that doesn't take into consideration for execution any file that matches its name
.PHONY:

ANDROID_HOME := /c/Users/kevin/AppData/Local/Android/Sdk
PATH := $(ANDROID_HOME)/platform-tools:$(ANDROID_HOME)/cmdline-tools/latest/bin:$(PATH)

help: 			## Show this help.
	@fgrep -h "##" ${MAKEFILE_LIST} | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

clean: 			## Clean project and get depedencies.
	flutter clean
	flutter pub get

build-apk: 		## Build apk with release version.
	flutter build apk --release --target=lib/main.dart

build-aab: 		## Build aab with release version.
	flutter build appbundle --release --target=lib/main.dart

build-ipa: 		## Build ipa with release version.
	flutter build ipa --release --target=lib/main.dart --export-method=ad-hoc

run-debug: 		## Run project with debug version. (currently not supported)
	flutter run --debug --target=lib/main.dart

run-profile: 		## Run project with profile version. (currently not supported)
	flutter run --profile --target=lib/main.dart

run-release: 		## Run project with release version. (currently not supported)
	flutter run --release --target=lib/main.dart