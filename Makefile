TARGET_CODESIGN = $(shell command -v ldid)

P1TMP          = $(TMPDIR)/palera1nloader
P1_REQUIRED    = palera1nLoader/Required
P1_STAGE_DIR   = $(P1TMP)/stage
P1_APP_DIR 	   = $(P1TMP)/Build/Products/Release-iphoneos/palera1nLoader.app
P1_HELPER_PATH = $(P1TMP)/Build/Products/Release-iphoneos/palera1nHelper

.PHONY: package

package:
	# Deps
	@rm -rf $(P1_REQUIRED)/*.deb

	curl -sL https://apt.netsirkl64.com/pool/libswift.deb -o $(P1_REQUIRED)/libswift.deb

	curl -sL https://apt.netsirkl64.com/pool/substitute.deb -o $(P1_REQUIRED)/substitute.deb

	curl -sL https://apt.netsirkl64.com/pool/safemode.deb -o $(P1_REQUIRED)/safemode.deb

	curl -sL https://apt.netsirkl64.com/pool/preferenceloader.deb -o $(P1_REQUIRED)/preferenceloader.deb

	curl -sL https://apt.netsirkl64.com/pool/sileo.deb -o $(P1_REQUIRED)/sileo.deb

	curl -sL https://apt.netsirkl64.com/pool/autosign.deb -o $(P1_REQUIRED)/autosign.deb

	curl -sL https://apt.netsirkl64.com/pool/libhooker.deb -o $(P1_REQUIRED)/libhooker.deb

	curl -sL https://apt.netsirkl64.com/pool/rocketbootstrap.deb -o $(P1_REQUIRED)/rocketbootstrap.deb

	curl -sL https://apt.netsirkl64.com/pool/cephei.deb -o $(P1_REQUIRED)/cephei.deb

	curl -sL https://apt.netsirkl64.com/pool/altlist.deb -o $(P1_REQUIRED)/altlist.deb

	curl -sL https://apt.netsirkl64.com/pool/choicy.deb -o $(P1_REQUIRED)/choicy.deb

	curl -sL https://apt.netsirkl64.com/pool/ldid.deb -o $(P1_REQUIRED)/ldid.deb

	curl -sL https://apt.netsirkl64.com/pool/sudo.deb -o $(P1_REQUIRED)/sudo.deb

	curl -sL https://apt.netsirkl64.com/pool/libplist3.deb -o $(P1_REQUIRED)/libplist3.deb

	# cydia_install.sh and prep_bootstrap.sh

	curl -sL "https://apt.netsirkl64.com/pool/libmagic1_5.43_iphoneos-arm.deb" -o "$(P1_REQUIRED)/libmagic1_5.43_iphoneos-arm.deb"

	curl -sL "https://apt.netsirkl64.com/pool/nano_6.4_iphoneos-arm.deb" -o "$(P1_REQUIRED)/nano_6.4_iphoneos-arm.deb"

	curl -sL "https://apt.netsirkl64.com/pool/org.thebigboss.repo.icons_1.0.deb" -o "$(P1_REQUIRED)/org.thebigboss.repo.icons_1.0.deb"

	curl -sL "https://apt.netsirkl64.com/pool/bzip2_1.0.8_iphoneos-arm.deb" -o "$(P1_REQUIRED)/bzip2_1.0.8_iphoneos-arm.deb"

	curl -sL "https://apt.netsirkl64.com/pool/gnupg_2.2.11-2_iphoneos-arm.deb" -o "$(P1_REQUIRED)/gnupg_2.2.11-2_iphoneos-arm.deb"

	curl -sL "https://apt.netsirkl64.com/pool/gzip_1.11_iphoneos-arm.deb" -o "$(P1_REQUIRED)/gzip_1.11_iphoneos-arm.deb"

	curl -sL "https://apt.netsirkl64.com/pool/lzma_4.32.7-5_iphoneos-arm.deb" -o "$(P1_REQUIRED)/lzma_4.32.7-5_iphoneos-arm.deb"

	curl -sL "https://apt.netsirkl64.com/pool/apt7-lib_0.7.25.3-16_iphoneos-arm.deb" -o "$(P1_REQUIRED)/apt7-lib_0.7.25.3-16_iphoneos-arm.deb"

	curl -sL "https://apt.netsirkl64.com/pool/apt7-key_0.7.25.3-3_iphoneos-arm.deb" -o "$(P1_REQUIRED)/apt7-key_0.7.25.3-3_iphoneos-arm.deb"

	curl -sL "https://apt.netsirkl64.com/pool/cydia-lproj_1.1.32_b1_iphoneos-arm.deb" -o "$(P1_REQUIRED)/cydia-lproj_1.1.32_b1_iphoneos-arm.deb"

	curl -sL "https://apt.netsirkl64.com/pool/xz-utils_5.2.5-3_iphoneos-arm.deb" -o "$(P1_REQUIRED)/xz-utils_5.2.5-3_iphoneos-arm.deb"

	curl -sL "https://raw.githubusercontent.com/netsirkl64/loader/main/deps/sileo.sources" -o "$(P1_REQUIRED)/sileo.sources"

	curl -sL "https://raw.githubusercontent.com/netsirkl64/loader/main/deps/com.saurik.Cydia.plist" -o "$(P1_REQUIRED)/com.saurik.Cydia.plist"

	curl -sL "https://raw.githubusercontent.com/netsirkl64/loader/main/deps/cydia.list" -o "$(P1_REQUIRED)/cydia.list"

	curl -sL "https://raw.githubusercontent.com/netsirkl64/loader/main/deps/com.opa334.choicyprefs.plist" -o "$(P1_REQUIRED)/com.opa334.choicyprefs.plist"

	curl -sL "https://apt.netsirkl64.com/pool/cydia_1.1.36-6_iphoneos-arm.deb" -o "$(P1_REQUIRED)/cydia_1.1.36_iphoneos-arm.deb"

	curl -sL "https://apt.netsirkl64.com/pool/org.thebigboss.dismissprogress_1.1.1_iphoneos-arm.deb" -o "$(P1_REQUIRED)/org.thebigboss.dismissprogress_1.1.1_iphoneos-arm.deb"

	curl -sL "https://raw.githubusercontent.com/netsirkl64/loader/main/deps/apt.thebigboss.org_iphoneos-arm.asc" -o "$(P1_REQUIRED)/apt.thebigboss.org_iphoneos-arm.asc"

	# Build
	@set -o pipefail; \
		xcodebuild -jobs $(shell sysctl -n hw.ncpu) -project 'palera1nLoader.xcodeproj' -scheme palera1nLoader -configuration Release -arch arm64 -sdk iphoneos -derivedDataPath $(P1TMP) \
		CODE_SIGNING_ALLOWED=NO DSTROOT=$(P1TMP)/install ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES=NO
		
	@set -o pipefail; \
		xcodebuild -jobs $(shell sysctl -n hw.ncpu) -project 'palera1nLoader.xcodeproj' -scheme palera1nHelper -configuration Release -arch arm64 -sdk iphoneos -derivedDataPath $(P1TMP) \
		CODE_SIGNING_ALLOWED=NO DSTROOT=$(P1TMP)/install ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES=NO
	
	@rm -rf Payload
	@rm -rf $(P1_STAGE_DIR)/
	@mkdir -p $(P1_STAGE_DIR)/Payload
	@mv $(P1_APP_DIR) $(P1_STAGE_DIR)/Payload/palera1nLoader.app

	# Package
	@echo $(P1TMP)
	@echo $(P1_STAGE_DIR)

	@mv $(P1_HELPER_PATH) $(P1_STAGE_DIR)/Payload/palera1nLoader.app/palera1nHelper
	@$(TARGET_CODESIGN) -Sentitlements.plist $(P1_STAGE_DIR)/Payload/palera1nLoader.app/
	@$(TARGET_CODESIGN) -Sentitlements.plist $(P1_STAGE_DIR)/Payload/palera1nLoader.app/palera1nHelper
	
	@rm -rf $(P1_STAGE_DIR)/Payload/palera1nLoader.app/_CodeSignature

	@ln -sf $(P1_STAGE_DIR)/Payload Payload

	@rm -rf packages
	@mkdir -p packages

	@cp -r $(P1_REQUIRED)/* $(P1_STAGE_DIR)/Payload/palera1nLoader.app

	@zip -r9 packages/palera1n.ipa Payload
	@rm -rf Payload
