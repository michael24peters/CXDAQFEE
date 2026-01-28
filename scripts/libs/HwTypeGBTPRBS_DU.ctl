#uses "fwPRBS/PRBSFsm.ctl"
HwTypeGBTPRBS_DU_initialize(string domain, string device)
{
  PRBSFsm_HwTypeGBTPRBS_DU_initialize(domain, device);
}
HwTypeGBTPRBS_DU_valueChanged( string domain, string device,
      int state, string &fwState )
{
  PRBSFsm_HwTypeGBTPRBS_DU_valueChanged(domain, device, state, fwState);
}


HwTypeGBTPRBS_DU_doCommand(string domain, string device, string command)
{
  PRBSFsm_HwTypeGBTPRBS_DU_doCommand(domain, device, command);
}
