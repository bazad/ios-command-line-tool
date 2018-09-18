PROJECT = ios-command-line-tool.xcodeproj

include vars.mk

.PHONY: all clean

all:
	xcodebuild \
		-project "$(PROJECT)" \
		ARCHS="arm64" \
		DEVELOPMENT_TEAM="$(DEV_TEAM)" \
		IPHONEOS_DEPLOYMENT_TARGET="$(IOS_TARGET)" \
		build

clean:
	xcodebuild \
		-project "$(PROJECT)" \
		ARCHS="arm64" \
		DEVELOPMENT_TEAM="$(DEV_TEAM)" \
		IPHONEOS_DEPLOYMENT_TARGET="$(IOS_TARGET)" \
		clean
