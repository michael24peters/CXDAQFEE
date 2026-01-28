HwTypeGENERICTOPFrontEnd_DU_initialize(string domain, string device)
{
}

HwTypeGENERICTOPFrontEnd_DU_valueChanged( string domain, string device,
      int P_FE_ENB_1,
      int P_FE_ENB_2,
      int S_FE_SYNCH_CNT, string &fwState )
{
	if (
	((P_FE_ENB_1 > 0x000000) ||
	(P_FE_ENB_2 > 0x000000)) &&
	(S_FE_SYNCH_CNT > 0) )
	{
		fwState = "RUNNING";
	}
	else if (
	(P_FE_ENB_1 > 0x000000) ||
	(P_FE_ENB_2 > 0x000000) )
	{
		fwState = "READY";
	}
	else if (
	(P_FE_ENB_1 == 0x000000) &&
	(P_FE_ENB_2 == 0x000000) )
	{
		fwState = "NOT_READY";
	}
	else
	{
		fwState = "ERROR";
	}
}


#uses "fwTOP/fwTOP.ctl"
HwTypeGENERICTOPFrontEnd_DU_doCommand(string domain, string device, string command)
{
  if (command == "STOP")
  {
//     dpSet(device+".CN", 0);
    //fwTop_enableFEGen(dpSubStr(device, DPSUB_SYS_DP));
  fwTop_FEreset(dpSubStr(device, DPSUB_SYS_DP));
//     fwDU_setState(domain, device, "READY");
  }
  if (command == "RESET")
  {
    fwTop_disableFEGen(dpSubStr(device, DPSUB_SYS_DP));
  fwTop_FEreset(dpSubStr(device, DPSUB_SYS_DP));
  }
  if (command == "START")
  {
    //fwTop_enableFEGen(dpSubStr(device, DPSUB_SYS_DP));
  }
  if (command == "CONFIGURE")
  {
  int dataOrigin;
  dpGet(dpSubStr(device, DPSUB_SYS_DP)+".Top.TOPFrontEnd.P_FE_DATA_ORIGIN", dataOrigin);
  DebugTN("Data Origin set to ", dataOrigin);
  if(dataOrigin == 2)
  {
    fwTop_LoadFileData(dpSubStr(device, DPSUB_SYS_DP)+".Top.TOPFrontEnd");
  }
    fwTop_enableFEGen(dpSubStr(device, DPSUB_SYS_DP));
  }
  if (command == "RECOVER")
  {
//     fwTop_reset(dpSubStr(device, DPSUB_SYS_DP));
    fwTop_disableFEGen(dpSubStr(device, DPSUB_SYS_DP));
  fwTop_FEreset(dpSubStr(device, DPSUB_SYS_DP));
  }
}


