#!/bin/sh
# Openshift BPMS Smart Router launch script

source ${LAUNCH_DIR}/logging.sh

if [ "${SCRIPT_DEBUG}" = "true" ] ; then
    set -x
    log_info "Script debugging is enabled, allowing bash commands and their arguments to be printed as they are executed"
fi

CONFIGURE_SCRIPTS=(
  ${LAUNCH_DIR}/bpmsuite-smartrouter.sh
)

source ${LAUNCH_DIR}/configure.sh

log_info "Running $JBOSS_IMAGE_NAME image, version $PRODUCT_VERSION"

if [ -n "$CLI_GRACEFUL_SHUTDOWN" ] ; then
  trap "" TERM
  log_info "Using CLI Graceful Shutdown instead of TERM signal"
fi

# eval instead of exec to handle spaces in system properties (like passwords per RHPAM-1135)
eval  ${JAVA_HOME}/bin/java ${JBOSS_BPMSUITE_ARGS} -jar /opt/${JBOSS_PRODUCT}/${KIE_ROUTER_DISTRIBUTION_JAR}
