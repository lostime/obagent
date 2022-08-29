#!/bin/bash

OBAGENT_USERNAME=$1
OBAGENT_PASSWORD=$2
OB_ORACLE_USERNAME=$3
OB_ORACLE_PASSWORD=$4
OB_ORACLE_SERVICE_NAME=$5
OB_SQL_PORT=$5

OBAGENT_DIR=/home/admin/obagent

replace_property_basic
replace_property_pipeline
replace_module_basic

export PKG_CONFIG_PATH=/home/admin/obagent
export LD_LIBRARY_PATH=/u01/obclient/lib/:$LD_LIBRARY_PATH
export GO111MODULE=off
export NLS_LANG=AMERICAN_AMERICA.UTF8
cd /home/admin/obagent && ./bin/monagent -c conf/monagent.yaml

# replace field in config_properties/monagent_basic_auth.yaml
function replace_property_basic() {
    sed -i "s/{http_basic_auth_user}/${OBAGENT_USERNAME}/g" "${OBAGENT_DIR}/conf/config_properties/monagent_basic_auth.yaml"
    sed -i "s/{http_basic_auth_password}/${OBAGENT_PASSWORD}/g" "${OBAGENT_DIR}/conf/config_properties/monagent_basic_auth.yaml"
    sed -i "s/{pprof_basic_auth_user}/${OBAGENT_USERNAME}/g" "${OBAGENT_DIR}/conf/config_properties/monagent_basic_auth.yaml"
    sed -i "s/{pprof_basic_auth_password}/${OBAGENT_PASSWORD}/g" "${OBAGENT_DIR}/conf/config_properties/monagent_basic_auth.yaml"
}

# replace field in config_properties/monagent_pipeline.yaml
function replace_property_pipeline() {
    sed -i "s/{monitor_user}/ob_monitor/g" "${OBAGENT_DIR}/conf/config_properties/monagent_pipeline.yaml"
    sed -i "s/{monitor_password}//g" "${OBAGENT_DIR}/conf/config_properties/monagent_pipeline.yaml"
    sed -i "s/{sql_port}/${OB_SQL_PORT}/g" "${OBAGENT_DIR}/conf/config_properties/monagent_pipeline.yaml"
    sed -i "s/{rpc_port}/2882/g" "${OBAGENT_DIR}/conf/config_properties/monagent_pipeline.yaml"
    sed -i "s/{ob_install_path}/\/home\/admin\/oceanbase/g" "${OBAGENT_DIR}/conf/config_properties/monagent_pipeline.yaml"
    sed -i "s/{host_ip}/127.0.0.1/g" "${OBAGENT_DIR}/conf/config_properties/monagent_pipeline.yaml"
    sed -i "s/{cluster_name}/obCluster/g" "${OBAGENT_DIR}/conf/config_properties/monagent_pipeline.yaml"
    sed -i "s/{cluster_id}/1/g" "${OBAGENT_DIR}/conf/config_properties/monagent_pipeline.yaml"
    sed -i "s/{zone_name}/obZone/g" "${OBAGENT_DIR}/conf/config_properties/monagent_pipeline.yaml"
    sed -i "s/{ob_monitor_status}/inactive/g" "${OBAGENT_DIR}/conf/config_properties/monagent_pipeline.yaml"
    sed -i "s/{ob_log_monitor_status}/inactive/g" "${OBAGENT_DIR}/conf/config_properties/monagent_pipeline.yaml"
    sed -i "s/{host_monitor_status}/inactive/g" "${OBAGENT_DIR}/conf/config_properties/monagent_pipeline.yaml"
    sed -i "s/{alertmanager_address}/127.0.0.1/g" "${OBAGENT_DIR}/conf/config_properties/monagent_pipeline.yaml"
    sed -i "s/{ob.oracle.user}/${OB_ORACLE_USERNAME}/g" "${OBAGENT_DIR}/conf/config_properties/monagent_pipeline.yaml"
    sed -i "s/{ob.oracle.password}/${OB_ORACLE_PASSWORD}/g" "${OBAGENT_DIR}/conf/config_properties/monagent_pipeline.yaml"
    sed -i "s/{ob.oracle.server.name}/${OB_ORACLE_SERVICE_NAME}/g" "${OBAGENT_DIR}/conf/config_properties/monagent_pipeline.yaml"
}

# replace field in module_config/monagent_basic_auth.yaml
function replace_module_basic() {
    sed -i "s/{disable_http_basic_auth}/true/g" "${OBAGENT_DIR}/conf/module_config/monagent_basic_auth.yaml"
    sed -i "s/{disable_pprof_basic_auth}/true/g" "${OBAGENT_DIR}/conf/module_config/monagent_basic_auth.yaml"
}