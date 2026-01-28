GbtFastStepRun_DU_initialize(string domain, string device)
{

}
GbtFastStepRun_DU_valueChanged( string domain, string device,
      int state, string &fwState )
{
  if (state == 0)
  {
    fwState = "NOT_READY";
  }
  else if (state == 1)
  {
    fwState = "READY";
  }
  else if (state == 2)
  {
    fwState = "RUNNING";
  }
  else
  {
    fwState = "ERROR";
  }
}


#uses "fwTFC/fwSOL40.lctl"
#uses "fwGbt.ctl"
GbtFastStepRun_DU_doCommand(string domain, string device, string command)
{
  string autoStepFile;

  if (command == "CONFIGURE")
  {
    dpSet(device+".state",1);
  }
  if (command == "START" ||
      command == "START_RUN")
  {
    fwDU_getCommandParameter(domain, device, "AUTO_STEP_FILE", autoStepFile);
    if (autoStepFile!="") {
      SOL40Fsm_enableAutoStep(device, autoStepFile);
    }
    dpSet(device+".state",2);
  }
  if (command == "RESET")
  {
    dpSet(device+".state",0);
  }
  if (command == "STOP" ||
      command == "STOP_RUN")
  {
    dpSet(device+".state",1);
  }
  if (command == "RECOVER")
  {
    dpSet(device+".state",0);
  }
}

SOL40Fsm_enableAutoStep(string device, string autoStepFile)
{
  string gbtServer = _fwTop_getGbtServPC(device);
DebugTN(__FUNCTION__, __LINE__, "enabling auto step run", autoStepFile);
  _fwGbt_enableAutoStepRun(gbtServer, autoStepFile);
}
