#uses "fwTFC/fwSOL40.lctl"
#uses "fwTFC/SOL40Fsm.ctl"
#uses "fwTell40/fwTell40.ctl"

HwTypeGBTQ_SOL40_DU_initialize(string domain, string device)
{
  SOL40Fsm_HwTypeGBTQ_SOL40_DU_initialize(domain, device);
}
HwTypeGBTQ_SOL40_DU_valueChanged( string domain, string device,
      int SOL40Commands_dot_EC_READY,
      int SOL40Commands_dot_EC_RUNNING,
      int SOL40Counters_dot_C_BXID_RST_INT,
      int SOL40Counters_dot_C_SYNCH,
      int SOL40Counters_dot_C_BXID_RESET,
      string &fwState )
{
	SOL40Fsm_HwTypeGBTQ_SOL40_DU_valueChanged(domain, device,
                                            SOL40Commands_dot_EC_READY,
                                            SOL40Commands_dot_EC_RUNNING,
                                            SOL40Counters_dot_C_BXID_RST_INT,
                                            SOL40Counters_dot_C_SYNCH,
                                            SOL40Counters_dot_C_BXID_RESET,
                                            fwState);
}


HwTypeGBTQ_SOL40_DU_doCommand(string domain, string device, string command)
{
  SOL40Fsm_HwTypeGBTQ_SOL40_DU_doCommand(domain, device, command);
}


