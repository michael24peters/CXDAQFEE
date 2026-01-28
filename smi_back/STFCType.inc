class: ASS_STFCType_CLASS/associated
!panel: STFCType.pnl
    state: NOT_READY
    !color: FwStateAttention1
        action: CONFIGURE(string RUN_TYPE = "PHYSICS", string RUN_INFO_DP = "")	!visible: 1
        action: RESET	!visible: 1
    state: READY
    !color: FwStateOKNotPhysics
        action: START_RUN(int N_TRIGGERS = 0, string AUTO_STEP_FILE = "")	!visible: 0
        action: START(int N_TRIGGERS = 0, string AUTO_STEP_FILE = "")	!visible: 1
        action: RESET	!visible: 1
    state: RUNNING
    !color: FwStateOKPhysics
        action: STOP_RUN	!visible: 0
        action: STOP	!visible: 1
        action: RESET	!visible: 1
    state: ERROR
    !color: FwStateAttention3
        action: RECOVER	!visible: 1
