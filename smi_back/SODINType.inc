class: ASS_SODINType_CLASS/associated
!panel: SODINType.pnl
    state: NOT_READY
    !color: FwStateAttention1
        action: CONFIGURE(int STEP_NR = -1, string RUN_TYPE = "PHYSICS")	!visible: 1
        action: RESET	!visible: 1
    state: READY
    !color: FwStateOKNotPhysics
        action: START_RUN(int N_TRIGGERS = 0, int STEP_NR = 0, float STEP_PERIOD = 0.0)	!visible: 0
        action: START(int N_TRIGGERS = 0, int STEP_NR = 0, int STEP_PERIOD = 0)	!visible: 1
        action: RESET	!visible: 1
    state: ACTIVE
    !color: FwStateOKNotPhysics
        action: STOP_RUN	!visible: 0
        action: STOP	!visible: 1
        action: START_TRIGGER(int N_TRIGGERS = 0, int STEP_NR = 0, float STEP_PERIOD = 0.0, int RUN_NUMBER = 0)	!visible: 1
        action: START(int N_TRIGGERS = 0, int STEP_NR = 0, int STEP_PERIOD = 0)	!visible: 0
        action: START_RUN	!visible: 0
        action: START_SCAN	!visible: 0
        action: STOP_SCAN	!visible: 0
        action: RESET	!visible: 1
    state: PAUSED
    !color: FwStateOKNotPhysics
        action: STOP_RUN	!visible: 0
        action: STOP	!visible: 1
        action: CONTINUE(int N_TRIGGERS = 0, float STEP_PERIOD = 0.0)	!visible: 1
        action: STOP_TRIGGER	!visible: 1
        action: RESET	!visible: 1
    state: RUNNING
    !color: FwStateOKPhysics
        action: STOP_RUN	!visible: 0
        action: STOP	!visible: 1
        action: PAUSE	!visible: 1
        action: STOP_TRIGGER	!visible: 1
        action: STOP_SCAN	!visible: 1
    state: ERROR
    !color: FwStateAttention3
        action: RECOVER	!visible: 1
