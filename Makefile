# Generate code for all the packages with dynamic features
watch:
	@echo "==> 👀 Watching for changes in packages with dynamic features"
	@fvm flutter pub run build_runner watch --delete-conflicting-outputs --verbose

format:
	@echo "==> 🧹 Formatting the code"
	@fvm dart format lib test

lint:
	@echo "==> 🧼 Linting"
	@fvm flutter analyze lib test

clean-runner:
	@echo "==> 🧹 Clearing build runner"
	@fvm flutter packages pub run build_runner clean

all:
	@echo "==> 🚧 Executing all checks"
	@make format
	@make lint
