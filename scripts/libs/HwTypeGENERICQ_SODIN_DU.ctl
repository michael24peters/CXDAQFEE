#uses "fwTFC/SODINFsm.ctl"
HwTypeGENERICQ_SODIN_DU_initialize(string domain, string device)
{
  SODINFsm_HwTypeGENERICQ_SODIN_DU_initialize(domain, device);
}
HwTypeGENERICQ_SODIN_DU_valueChanged( string domain, string device,
      int Commands_dot_EC_RUNNING,
      int Commands_dot_EC_ACTIVE,
      int Commands_dot_EC_READY,
      int Enables_dot_P_SCAN_ENB,
      int Counters_dot_C_TRIGGERS_GT_ALL,
      int Triggers_dot_P_LIMIT_TRG,
      int Enables_dot_P_LIMIT_TRG_ENB,
      int Enables_dot_P_STEPRUN_AUTOMATIC_ENB,
      int Counters_dot_C_ENDOFSTEP, string &fwState )
{
  SODINFsm_HwTypeGENERICQ_SODIN_DU_valueChanged(domain, device,
      Commands_dot_EC_RUNNING,
      Commands_dot_EC_ACTIVE,
      Commands_dot_EC_READY,
      Enables_dot_P_SCAN_ENB,
      Counters_dot_C_TRIGGERS_GT_ALL,
      Triggers_dot_P_LIMIT_TRG,
      Enables_dot_P_LIMIT_TRG_ENB,
      Enables_dot_P_STEPRUN_AUTOMATIC_ENB,
      Counters_dot_C_ENDOFSTEP, fwState);

  if (fwState=="")
    return;
}


HwTypeGENERICQ_SODIN_DU_doCommand(string domain, string device, string command)
{
  SODINFsm_HwTypeGENERICQ_SODIN_DU_doCommand(domain, device, command);
}
