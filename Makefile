# define standard colors
ifneq (,$(findstring xterm,${TERM}))
	BLACK        := $(shell tput -Txterm setaf 0)
	RED          := $(shell tput -Txterm setaf 1)
	GREEN        := $(shell tput -Txterm setaf 2)
	YELLOW       := $(shell tput -Txterm setaf 3)
	LIGHTPURPLE  := $(shell tput -Txterm setaf 4)
	PURPLE       := $(shell tput -Txterm setaf 5)
	BLUE         := $(shell tput -Txterm setaf 6)
	WHITE        := $(shell tput -Txterm setaf 7)
	RESET := $(shell tput -Txterm sgr0)
else
	BLACK        := ""
	RED          := ""
	GREEN        := ""
	YELLOW       := ""
	LIGHTPURPLE  := ""
	PURPLE       := ""
	BLUE         := ""
	WHITE        := ""
	RESET        := ""
endif

# set target color
TARGET_COLOR := $(BLUE)

POUND = \#

.PHONY: no_targets__ info help build deploy doc
	no_targets__:

.DEFAULT_GOAL := help

colors: ## すべての色を表示する
	@echo "${BLACK}BLACK${RESET}"
	@echo "${RED}RED${RESET}"
	@echo "${GREEN}GREEN${RESET}"
	@echo "${YELLOW}YELLOW${RESET}"
	@echo "${LIGHTPURPLE}LIGHTPURPLE${RESET}"
	@echo "${PURPLE}PURPLE${RESET}"
	@echo "${BLUE}BLUE${RESET}"
	@echo "${WHITE}WHITE${RESET}"

.PHONY: all
all: clean setup run_dev_mock

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup:## プロジェクトのセットアップ
	@echo "${GREEN}╠ プロジェクトのセットアップ${RESET}"
	@fvm flutter pub get
	@fvm flutter packages pub run build_runner build --delete-conflicting-outputs

.PHONY: gen
gen: ## ワンタイムコード生成をトリガーする
	@echo "${BLUE}コードの生成。。。。${RESET}"
	@fvm flutter pub run build_runner build --delete-conflicting-outputs

.PHONY: watch
watch: ## ファイルを監視し、変更時にコード生成をトリガーする
	@echo "${BLUE}コードの生成。。。。${RESET}"
	@fvm flutter pub run build_runner watch --delete-conflicting-outputs

.PHONY: analyze
analyze: ## コードを分析する
	@fvm flutter analyze
	@fvm flutter pub run dart_code_metrics:metrics analyze lib

.PHONY: run_dev_mock
run_dev_mock: ## dev でモバイル アプリケーションを実行します
	@echo "${GREEN}╠ dev でダミー データを使用してアプリを実行する${RESET}"
	@fvm flutter run --flavor dev lib/main_dev.dart

.PHONY: run_stg
run_stg: ## stg でモバイル アプリケーションを実行します
	@echo "${GREEN}╠ stgでダミー データを使用してアプリを実行する${RESET}"
	@fvm flutter run --flavor staging lib/main_stg.dart

.PHONY: format
format: ## コードのフォーマット
	@echo "${YELLOW}╠ コードのフォーマット${RESET}"
	@dart format .

.PHONY: lint
lint: ## コードをリントします
	@echo "${YELLOW}╠ コードを確認しています。。。。${RESET}"
	@dart analyze . || (echo "${RED}プロジェクトのエラー${RESET}"; exit 1)

.PHONY: upgrade
upgrade: clean ## 依存関係をアップグレードする
	@echo "${LIGHTPURPLE}╠ 依存関係をアップグレード中。。。${RESET}"
	@fvm flutter pub upgrade

.PHONY: clean
clean: ## 環境をきれいにします。
	@echo "${YELLOW}╠ プロジェクトをクリーニング中。。。。${RESET}"
	@rm -rf pubspec.lock
	@fvm flutter clean

.PHONY: run_unit_test
run_unit_test: ## テストを実行します
	@echo "${GREEN}╠ テストの実行する${RESET}"
	@fvm flutter test || (echo "${RED}テスト実行中のエラー${RESET}"; exit 1)

.PHONY: build_apk_android_dev
build_android_dev: ## dev で apk アプリケーションをビルドする
	@echo "${GREEN}╠ devのapk をビルドする${RESET}"
	fvm flutter build apk --flavor dev --target lib/main_dev.dart

.PHONY: build_apk_android_dev
build_app_bundle_android_dev: ## dev でアプリ バンドル アプリケーションをビルドする
	@echo "${GREEN}╠ devのapk をビルドする${RESET}"
	fvm flutter build appbundle --flavor dev --target lib/main_dev.dart

.PHONY: build_apk_android_stg
build_android_staging: ## ステージングで apk バンドル アプリケーションをビルドする
	@echo "${GREEN}╠ stgのAPK のビルド${RESET}"
	fvm flutter build apk --flavor staging --target lib/main_staging.dart

.PHONY: build_apk_android_stg
build_app_bundle_android_staging: ## ステージングで App Bundle アプリケーションをビルドする
	@echo "${GREEN}╠ stgのAPK のビルド${RESET}"
	fvm flutter build appbundle --flavor staging --target lib/main_staging.dart

.PHONY: build_apk_android_dev
build_ios_dev: ## dev で iOS アプリケーションをビルドする
	@echo "${GREEN}╠ devのAPK のビルド${RESET}"
	fvm flutter build ios --flavor dev --target lib/main_dev.dart

.PHONY: build_apk_android_stg
build_ios_staging: ## ステージングで iOS アプリケーションをビルドする
	@echo "${GREEN}╠ stgのAPK のビルド${RESET}"
	@fvm flutter build ios --flavor staging --target lib/main_staging.dart

.PHONY: lefthook
lefthook: ## lefthookインストール
	@echo "${GREEN}╠ lefthook設定する (pre-commit | pre-push)${RESET}"
	@npm install @evilmartians/lefthook-installer --save-dev && npx lefthook install

.PHONY: flavor
flavor: ## lefthookインストール
	@echo "${GREEN}╠ flavorを更新する${RESET}"
	@fvm flutter pub run fvm flutter_flavorizr -p android:buildGradle,android:androidManifest,ios:xcconfig,ios:buildTargets,ios:schema,ios:plist

.PHONY: delete generated file
delete-generate-file: ## コード生成を削除
	@echo "コード生成を削除"
	@find . -maxdepth 20 -type f \( -name "*.freezed.dart" -o  -name "*.g.dart" \) -delete