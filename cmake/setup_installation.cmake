include(CMakePackageConfigHelpers)

set(exported_targets_name "${PROJECT_NAME}Targets")
set(exported_targets_filename "${exported_targets_name}.cmake")
set(export_dirpath "share/cmake/${PROJECT_NAME}")
set(config_basename "${PROJECT_NAME}Config")
set(config_filename "${config_basename}.cmake")
set(version_filename "${config_basename}Version.cmake")

message(STATUS "config_basename = ${config_basename}")
message(STATUS "config_filename = ${config_filename}")
message(STATUS "version_filename = ${version_filename}")

write_basic_package_version_file(
        ${version_filename}
        COMPATIBILITY SameMajorVersion
)

configure_package_config_file(
        "cmake/${config_filename}.in" "${config_filename}"
        INSTALL_DESTINATION "${export_dirpath}"
)

install(
        TARGETS ${PROJECT_NAME}
        EXPORT ${exported_targets_name}
        ARCHIVE DESTINATION lib
        PUBLIC_HEADER DESTINATION include/safeheron
)

install(
        EXPORT ${exported_targets_name}
        FILE ${exported_targets_filename}
        DESTINATION ${export_dirpath}
)

install(
        FILES
            "${CMAKE_CURRENT_BINARY_DIR}/${config_filename}"
            "${CMAKE_CURRENT_BINARY_DIR}/${version_filename}"
        DESTINATION
            ${export_dirpath}
)

## Install head files
install(
        DIRECTORY src/
        DESTINATION include/safeheron
        FILES_MATCHING PATTERN "*.h"
        PATTERN "ed25519_ex.h" EXCLUDE
        PATTERN "openssl_curve_wrapper.h" EXCLUDE

        PATTERN "hash_wrapper.h" EXCLUDE
        PATTERN "memzero.h" EXCLUDE
        PATTERN "internal.h" EXCLUDE
        PATTERN "wally_bip39.h" EXCLUDE
        PATTERN "wally_mnemonic.h" EXCLUDE
        PATTERN "wordlist.h" EXCLUDE
        PATTERN "crypto-bip39/data" EXCLUDE
)

## Install proto files
install(
        DIRECTORY proto/
        DESTINATION include/safeheron/proto
        FILES_MATCHING PATTERN "*.proto"
)
