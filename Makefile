SCHEMAS_DIR = "./schemas/"
SCHEMAS_FILE = "gschemas.compiled"
EXTENSION_UUID := $(shell jq -r '.uuid' ./metadata.json)
TARGET_PATH = "${HOME}/.local/share/gnome-shell/extensions/${EXTENSION_UUID}"
PARENT_PATH = $(shell cd .. && pwd)
PACKAGE_PATH = "${PARENT_PATH}/${EXTENSION_UUID}-package"
PACKAGE_FILE = "${PARENT_PATH}/${EXTENSION_UUID}.zip"
 
# echo:
# 	echo 'SCHEMAS_DIR' $(SCHEMAS_DIR)
# 	echo 'SCHEMAS_FILE' $(SCHEMAS_FILE)
# 	echo 'EXTENSION_UUID' $(EXTENSION_UUID)
# 	echo 'TARGET_PATH' $(TARGET_PATH)
# 	echo 'PARENT_PATH' $(PARENT_PATH)
# 	echo 'PACKAGE_PATH' $(PACKAGE_PATH)
# 	echo 'PACKAGE_FILE' $(PACKAGE_FILE)

clean:
	rm $(SCHEMAS_DIR)$(SCHEMAS_FILE)

build:
	glib-compile-schemas $(SCHEMAS_DIR)

install: build
	rm -r -f "${TARGET_PATH}"
	cp -r "${PWD}" "${TARGET_PATH}"

clean_package:
	rm -rf "${PACKAGE_PATH}"
	rm "${PACKAGE_FILE}"

package: clean_package build
	cp -r "${PWD}" "${PACKAGE_PATH}"
	rm -r -f "${PACKAGE_PATH}/.git"
	eval rm -f "${PACKAGE_PATH}/*.sh"
	rm -f "${PACKAGE_PATH}/Makefile"

	cd "${PACKAGE_PATH}"
	zip -r "${PACKAGE_FILE}" "./"

	clean_package
